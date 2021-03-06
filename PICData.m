 classdef PICData
  %PICMap Generic particle-in-cell data class, dependent on time, x, and z coordinates   
  %
  %   PM = PICData(time,x,z,data,[ARGS])
  %

  properties (Access=protected)    
    data_
    t_ % time
    x_
    y_
    z_
    fullDim_
    tensorOrder_
    tensorBasis_
    coordinates_
    itype_ % number pointing to certain TYPE, see below
  end
  
  properties
    name = '';
    description = '';
    units = '';
  end
  
  properties (Dependent = true)
    time
    coordinates
    data
  end
  
  properties (SetAccess = immutable,Dependent = true)
    % cant be changed, to change one needs to make a new object
    % dependent means it links to a hidden property
    tensorOrder
    tensorBasis
  end
  
  properties (Constant = true, Hidden = true)
    % This sets some boundary conditions for what is allowed
    MAX_TENSOR_ORDER = 2;
    BASIS = {'xyz','rtp','rlp','rpz','xy','rp'};
    BASIS_NAMES = {'Cartesian','Cartesian 2D'};
    TYPE = {'positive','negative','positive negative'};
  end
  
  properties (SetAccess = protected)
    representation
  end
  
  properties
    %name = '';
    %description = '';
    picConversion = '';
    picData = [];
    userData = [];
  end
  
  methods
    function obj = PICData(t,x,z,data,varargin)
      if nargin == 0, obj.data_ = []; obj.t_ = []; return, end      
      if nargin<4, error('5 inputs required'), end
%       if ~isnumeric(data)
%         error('pic:PICMap:PICMap:badInputs',...
%           'DATA must be numeric')
%       end
      nt = numel(t);
      nx = numel(x);
      %ny = numel(y); % ignore y for now when checking dimensions
      nz = numel(z);            
      sizedata = size(data);
      
      if not(nt == sizedata(1))
        error('pic:PICdata:PICData:badInputs','numel(time) has to be size(data,1)')
      end
      if not(nx == sizedata(2))
        error('pic:PICdata:PICData:badInputs','numel(x) has to be size(data,2)')
      end
      if not(nz == sizedata(3))
        error('pic:PICdata:PICData:badInputs','numel(z) has to be size(data,3)')
      end
      %ndim_data = sizedata(4:end);
      %ndims_data = ndims(data(4:end));
      obj.fullDim_ = cell(ndims(data)-3,1); % time should not be included -> -1
      obj.representation = cell(ndims(data)-3,1); iDim = 1; % time should not be included -> -1
      for idim = 1:numel(obj.fullDim_)
        obj.fullDim_{idim} = true;
        obj.representation{idim} = {'x','y','z'};
      end
      
      obj.tensorBasis_ = 1;
      
      obj.coordinates_{1} = x;
      obj.coordinates_{2} = z;
    
      obj.data_ = data; 
      %obj.fullDim_ = cell(ndims(data)-3,1); % time should not be included -> -1
      
      %obj.fullDim_{1} = true;
      obj.t_ = t;
      
%      obj.fullDim_ = cell(ndims(data)-1,1); % time should not be included -> -1
      
      %obj.representation = cell(ndims(data),1); iDim = 1;
      % Why is the dimension of represenation set already here? When
      % picking out a component of a Tensor: T.xy, the data becomes 2D 
      % (time x T.xy), but the representation should have two 'dimensions':
      % 'x' and 'y'. This can be solved by resetting representation when
      % specifying tensor order, since tensor order hase to be specified
      % before settin representation.
      
      args = varargin;
      flagTensorOrderSet = false; flagTensorBasisSet = false;
      while ~isempty(args)
        x = args{1}; args(1) = [];
        switch lower(x)
          case {'tensor_xyz'}
            if ndims(obj.data_)>3 %#ok<ISMAT>
              error('irf:TSeries:TSeries:badInputs',...
                'DATA has more than 3 dimensions (needed for Tensor with order 2)')
            elseif size(obj.data_,2)~=3
              error('irf:TSeries:TSeries:badInputs',...
                'size(DATA,2) must be 3 for xyz tensor')
            elseif size(obj.data_,3)~=3
              error('irf:TSeries:TSeries:badInputs',...
                'size(DATA,3) must be 3 for xyz tensor')  
            end
            obj.tensorOrder_ = 2; flagTensorOrderSet = true;
            [~,iB] = intersect(obj.BASIS,x(8:10));
            obj.tensorBasis_ = iB; flagTensorBasisSet = true;
            obj.representation{1} = {x(8), x(9), x(10)}; % 1st dimension, (rows for 2D)
            obj.fullDim_{1} = true;
            obj.representation{2} = {x(8), x(9), x(10)}; % 2nd dimension, (cols for 2D)
            obj.fullDim_{2} = true;
          case {'vec_xyz'}
            if ndims(obj.data_)>2 %#ok<ISMAT>
              error('irf:TSeries:TSeries:badInputs',...
                'DATA has more than 2 dimensions (needed for 3D vec)')
            elseif size(obj.data_,2)~=3
              error('irf:TSeries:TSeries:badInputs',...
                'size(DATA,2) must be 3 for 3D vec')
            end
            obj.tensorOrder_ = 1; flagTensorOrderSet = true;
            [~,iB] = intersect(obj.BASIS,x(5:7));
            obj.tensorBasis_ = iB; flagTensorBasisSet = true;
            obj.representation{1} = {x(5), x(6), x(7)};
            obj.fullDim_{1} = true;
          case {'scalar'}
            obj.tensorOrder_ = 0; flagTensorOrderSet = true;                        
            obj.representation = {'x', 'z'}; obj.fullDim_{1} = true;
          case {'to','tensororder'}
            if flagTensorOrderSet
              error('irf:PICData:PICData:badInputs',...
                'tensorOrder already set')
            end      
            obj.tensorOrder_ = args{1};
            args = args(2:end);
           % obj.representation = cell(obj.tensorOrder,1);             
            iDim = 1;            
          case {'tb','basis','tensorbasis'}
            if flagTensorBasisSet
              error('irf:TSeries:TSeries:badInputs',...
                'tensorBasis already set')
            end
            if obj.tensorOrder_==0
              error('irf:TSeries:TSeries:badInputs',...
                'cannot set tensorBasis for a scalar (tensorOrder=0)')
            end
            if ~isempty(args), y = args{1}; args(1) = [];
            else
              error('irf:TSeries:TSeries:badInputs',...
                'tensorBasis requires a second argument')
            end
            [~,iB] = intersect(obj.BASIS,y);
            if ~isempty(iB)
              obj.tensorBasis_ = iB; flagTensorBasisSet = true;
            else
              error('irf:TSeries:TSeries:badInputs',...
                'tensorBasis value not recognized')
            end
          case {'rep','repres','representation'}
            if isempty(obj.tensorOrder_)
              error('irf:TSeries:TSeries:badInputs',...
                'Must specify TensorOrder first')
            end
            if iDim>(obj.tensorOrder) %ndims(data), % remove '+1' after obj.tensorOrder, since time should no longer be included
              error('irf:TSeries:TSeries:badInputs',...
                'Representation already set for all DATA dimensions')
            end
            if ~isempty(args), y = args{1}; args(1) = [];
            else
              error('irf:TSeries:TSeries:badInputs',...
                'Representation requires a second argument')
            end
            if isempty(y) && iDim<ndims(data)-1, iDim = iDim + 1;
            else
              [ok,msg] = validate_representation(y);
              if ~isempty(ok)
                obj.fullDim_{iDim}=ok; obj.representation{iDim} = y;
                iDim = iDim + 1;
              else
                error('irf:TSeries:TSeries:badInputs',msg)
              end
            end
          case 'depend'
          otherwise
            error('irf:TSeries:TSeries:badInputs',...
              'Unknown parameter')
        end
      end
      
      % XXX: TODO Validate if we have non-empty Representation set for
      % number of dimensions corresponding to tensor order
      
      function [ok,msg] = validate_representation(x)
        ok = []; msg = '';
        sDim = size(obj.data,iDim+3); tb = obj.BASIS{obj.tensorBasis_};
        if sDim>length(tb)
          msg = sprintf(...
            'Dimension %d size %d>%d (Basis=%s) cannot have Representation. Use Depend instead',...
            iDim,sDim,length(tb),tb);
          return
        end
        if ~iscell(x)
          msg = 'Representation requires a cell input'; return
        end
        if sDim>0 && sDim~=length(x)
          msg = sprintf('Representation requires a cell(%d) input',sDim);
          return
        end
        if ~all(cellfun(@(x) ischar(x) && length(x)==1,x))
          msg = sprintf(...
            'Representation requires char(%d) cells elements',...
            obj.tensorOrder_);
          return
        end
        s = sprintf('%s',char(x)');
        if length(s)~=length(unique(s))
          msg = sprintf(...
            'Representation (%s) contains repeating attributes',s);
          return
        end
        s = unique(s);
        c = length((intersect(tb,s)));
        if c == 0, msg = sprintf('Unrecognized representation');
        elseif length(s) == c, ok = true; % complete dim
        elseif length(s) < c, ok = false; % incomplete dim
        elseif length(s) > c
          d = setdiff(s,tb); s1 = sprintf('%s',char(d)');
          msg = sprintf(...
            'Unrecognized entries (%s) for representation ''%s''',s1,tb);
        else, error('should not be here')
        end
      end
    end
    
    function [varargout] = subsref(obj,idx)
      %SUBSREF handle indexing
      switch idx(1).type
        % Use the built-in subsref for dot notation
        case '.'
          [varargout{1:nargout}] = builtin('subsref',obj,idx);
        case '()'
          tmpEpoch = builtin('subsref',obj.time,idx(1));
          obj.t_ = tmpEpoch;
          idxTmp = repmat({':'}, ndims(obj.data), 1);
          idxTmp(1) = idx(1).subs;
          obj.data_ = obj.data_(idxTmp{:});
          if numel(idx) > 1
            obj = builtin('subsref',obj,idx(2:end));
          end
          [varargout{1:nargout}] = obj;
        case '{}'
          error('irf:TSeries:subsref',...
            'Not a supported subscripted reference')
      end
    end
       
    function value = get.data(obj)
      value = obj.data_;
    end    
    function value = get.time(obj)
      value = obj.t_;
    end    
    function value = get.coordinates(obj)
      value = obj.coordinates_;
    end   
    function value = basis(obj)
      value = obj.BASIS{obj.tensorBasis_};
    end    
    function value = get.tensorBasis(obj)
      value = [obj.BASIS{obj.tensorBasis_}...
        ' (' obj.BASIS_NAMES{obj.tensorBasis_} ')'];
    end    
    function value = get.tensorOrder(obj)
      value = obj.tensorOrder_;
    end        
    function obj = set.coordinates(obj,value)
      obj.t_ = value;
    end
        
    % Construction etc.
    function obj_out = append(obj,t,data)
      % check times to see if they overlap or something
      % find in which order to insert the new data
      
      % check data dimensions

      % make new obj
      obj_out = obj;
      %obj_out.t_ = 1
      
    end
    
    % Operations
    function obj = div(obj)
      obj = [];
    end
    function obj = grad(obj)
      obj = [];
    end     
    function obj_out = ddt(obj)
      obj_out = obj;
      dt = diff(obj_out.t_);
      obj_out.t_ = obj_out.t_(1:(end-1)) + 0.5*dt;
      obj_out.data_ = diff(obj_out.data_,1);
    end 
    
    % Cosmetics etc.
    function obj = lim(obj,xlim,zlim)
      x = obj.coordinates{1};
      z = obj.coordinates{2};      
      if isempty(xlim), xlim = x([1 end]); end
      if isempty(zlim), zlim = z([1 end]); end  
      % x
      if numel(xlim) == 1
        ipx = find(abs(x-xlim)==min(abs(x-xlim)));
      else
        ipx1 = find(x>xlim(1),1,'first');
        ipx2 = find(x<xlim(2),1,'last');
        ipx = ipx1:1:ipx2;
      end
      
      % z
      if numel(zlim) == 1
        ipz = find(abs(z-zlim)==min(abs(z-zlim)));
      else
        ipz1 = find(z>zlim(1),1,'first');
        ipz2 = find(z<zlim(2),1,'last');
        ipz = ipz1:1:ipz2;
      end
      
      obj.data_ = obj.data_(:,ipx,ipz,:,:,:,:,:,:);
      obj.coordinates_{1} = obj.coordinates_{1}(ipx);
      obj.coordinates_{2} = obj.coordinates_{2}(ipz);
    end
    function obj = smooth(obj,varargin)
      if isempty(varargin)
        varargin{1} = 1;
      end
      
      sizeData = size(obj.data);
      inds = obj.indices;
      nloops = numel(inds)-2; % loop for time and each component
      % reshape matrix so that the various sub indices becomes one linear
      % index
      dataOrder = 1:numel(sizeData);
      newDataOrder = [dataOrder([2 3 1]) dataOrder(4:end)];       
      tmpData = permute(obj.data_,newDataOrder);
      newSizeData = size(tmpData);
      tmpDataReshaped = reshape(tmpData,[newSizeData(1) newSizeData(2) prod(newSizeData(3:end))]);
      
      smoothDataReshaped = zeros(size(tmpDataReshaped));
      for ii = 1:prod(newSizeData(3:end))        
        %if not(isempty(varargin))
          smoothDataReshaped(:,:,ii) = smooth2(tmpDataReshaped(:,:,ii),varargin{1});
        %else
        %  smoothDataReshaped(:,:,ii) = smooth2(tmpDataReshaped(:,:,ii),1);
        %end                  
      end
      % shape data back
      smoothData = reshape(smoothDataReshaped,newSizeData);      
      origDataOrder = [dataOrder([3 1 2]) dataOrder(4:end)];       
      smoothData = permute(smoothData,origDataOrder);
      obj.data_ = smoothData;
    end  
    function obj = interp(obj)
      obj = [];
    end 
    
    % Arithmetics
    function obj = plus(obj1,obj2)
    end
    
    % Plotting
    function varargout = plot(obj,varargin)
      
      imagesc(obj.coordinates{1},obj.coordinates{2},squeeze(obj.data)')
    end
    
    % Get components
    function y = x(obj)
      %access X component
      [y,ok] = getComponent(obj,'x'); if ~ok, error('cannot get X'), end
    end
    function y = y(obj)
      %access Y component
      [y,ok] = getComponent(obj,'y'); if ~ok, error('cannot get Y'), end
    end
    function y = z(obj)
      %access Z component
      [y,ok] = getComponent(obj,'z'); if ~ok, error('cannot get Z'), end
    end
    function y = xx(obj)
      %access X component
      [y,ok] = getComponent(obj,'xx'); if ~ok, error('cannot get XX'), end
    end
    function y = xy(obj)
      %access X component
      [y,ok] = getComponent(obj,'xy'); if ~ok, error('cannot get XY'), end
    end
    function y = xz(obj)
      %access X component
      [y,ok] = getComponent(obj,'xz'); if ~ok, error('cannot get XZ'), end
    end
    function y = yx(obj)
      %access X component
      [y,ok] = getComponent(obj,'yx'); if ~ok, error('cannot get YX'), end
    end
    function y = yy(obj)
      %access X component
      [y,ok] = getComponent(obj,'yy'); if ~ok, error('cannot get YY'), end
    end
    function y = yz(obj)
      %access X component
      [y,ok] = getComponent(obj,'yz'); if ~ok, error('cannot get YZ'), end
    end
    function y = zx(obj)
      %access X component
      [y,ok] = getComponent(obj,'zx'); if ~ok, error('cannot get ZX'), end
    end
    function y = zy(obj)
      %access X component
      [y,ok] = getComponent(obj,'zy'); if ~ok, error('cannot get ZX'), end
    end
    function y = zz(obj)
      %access X component
      [y,ok] = getComponent(obj,'zz'); if ~ok, error('cannot get ZZ'), end
    end
           
    function l = length(obj)
			% LENGTH - number of data points in time series
			%
			% LENGTH(TS) - number of data points in TS
      if isempty(obj.t_), l = 0;
      else, l = numel(obj.t_);
      end
    end
    function inds = indices(obj)
      sizedata = size(obj.data);
      inds = cell(1,numel(sizedata));
      for idim = 1:numel(sizedata)
        inds{idim} = 1:sizedata(idim);
      end
    end
  end
  
  methods (Access=protected)
    function [res, ok] = getComponent(obj,comp)
      res = []; ok = false;
      nd = ndims(obj.data_)-3; % first is time
      if nd>6, error('we cannot support more than 5 dimensions'), end % we cannot support more than 5 dimensions
      teno = obj.tensorOrder_;
      if length(comp)~=teno, return, end
      basis = obj.BASIS{obj.tensorBasis_};
      if ~any(basis==comp(1)), return
      %elseif length(comp)==2 && ~any(char(obj.BASIS(obj.tensorBasis_))==comp(2))
      %  return
      end
      switch obj.tensorOrder_
        case 0, error('should no be here')
        case 1
          iDim = find((~cellfun(@isempty,obj.fullDim_)));
          iComp = find_iComp(comp);
          if isempty(iComp), return, end
          idx = cell(nd,1);
          for i = 1:nd
            idx{i} = 1:size(obj.data_,i);
            if i==iDim, idx{i} = iComp; end
          end
          % XXX: This is ugly, what is a better way of doing this?
          switch nd
            case 1, dataNew = obj.data_(:,:,:,idx{1});
            case 2, dataNew = obj.data_(:,:,:,idx{1},idx{2});
            case 3, dataNew = obj.data_(:,:,:,idx{1},idx{2},idx{3});
            case 4, dataNew = obj.data_(:,:,:,idx{1},idx{2},idx{3},idx{4});
            case 5, dataNew = obj.data_(:,:,:,idx{1},idx{2},idx{3},idx{4},idx{5},idx{6});
            otherwise, error('should no be here')
          end
          args = {obj.t_,obj.coordinates{1},obj.coordinates{2},dataNew,'TensorOrder',teno,'TensorBasis',basis};
          for i=1:nd
            if i==iDim, args = [args {'repres',{comp}}]; %#ok<AGROW>
            else, args = [args {'repres',{}}]; %#ok<AGROW>
            end
          end
          res = PICData(args{:}); res.name = sprintf('%s_%s',obj.name,comp);
          ok = true;
        case 2
          iDim = find((~cellfun(@isempty,obj.fullDim_)));
          iComp1 = find_iComp(comp(1));
          iComp2 = find_iComp(comp(2));
          iComp = [iComp1 iComp2];
          if any(isempty([iComp1 iComp2])), return, end
          idx = cell(nd,1);
          indDim = 1;
          for i = 1:nd
            idx{i} = 1:size(obj.data_,i);
            if i==iDim(indDim), idx{i} = iComp(indDim); indDim = indDim+1; end
          end
          % XXX: This is ugly, what is a better way of doing this?
          switch nd
            case 1, dataNew = obj.data_(:,idx{1});
            case 2, dataNew = obj.data_(:,idx{1},idx{2});
            case 3, dataNew = obj.data_(:,idx{1},idx{2},idx{3});
            case 4, dataNew = obj.data_(:,idx{1},idx{2},idx{3},idx{4});
            case 5
              dataNew = obj.data_(idx{1},idx{2},idx{3},idx{4},idx{5},idx{6});
            otherwise, error('should no be here')
          end
          args = {obj.t_,dataNew,'TensorOrder',teno,'TensorBasis',basis};
          indDim = 1;
          for i=1:nd
            if i==iDim(indDim),  args = [args {'repres',{comp(indDim)}}]; indDim = indDim+1;%#ok<AGROW>
            else, args = [args {'repres',{}}]; %#ok<AGROW>
            end
          end
          res = TSeries(args{:}); res.name = sprintf('%s_%s',obj.name,comp);
          ok = true;
        otherwise, error('should no be here')
      end
      function res = find_iComp(c)        
        rep = obj.representation{iDim}; lRep = numel(rep);
        if rep{1}==c, res = 1;
        elseif lRep>1 && rep{2}==c, res = 2;
        elseif lRep>2 && rep{3}==c, res = 3;
        else, res = [];
        end        
      end
      res.units = obj.units; res.picConversion = obj.picConversion;
    end
  end
  
end