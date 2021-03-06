function varargout = find_dist_peaks(f)
% find peaks of distributions
doPlot = 0;

f_size = size(f);
ndim = numel(f_size);

if ndim == 3
  all_peaks = [];
  for idim = 3%1:ndim
    %%
    f_tmp = squeeze(sum(f,idim));
    f_max = max(f(:));
    peak_array_tmp = imregionalmax(f_tmp,18);
    [rows,cols] = size(f_tmp);
    peaks_tmp = zeros(rows,cols);
    for irow = 1:rows
      [PKS,LOCS,W] = findpeaks(f_tmp(irow,:),'MinPeakProminence',f_max*1e-5);
      if not(isempty(PKS))
        %disp(sprintf('%g ',PKS))
        peaks_tmp(irow,LOCS) = PKS;
      end
      peaks_tmp(irow,LOCS) = PKS;
    end
    if doPlot
      %%
      nrows = 3;
      ncols = 1;
      npanels = nrows*ncols;
      for ipanel = 1:npanels  
        h(ipanel) = subplot(nrows,ncols,ipanel); 
      end
      isub = 1;
      if 1 % f_tmp
        hca = h(isub); isub = isub + 1;
        imagesc(hca,f_tmp)
        hca.YDir = 'normal';
      end
      if 1 % peak_array_tmp
        hca = h(isub); isub = isub + 1;
        imagesc(hca,peaks_tmp)
        hca.YDir = 'normal';
      end
      if 1 % peak_array_tmp
        hca = h(isub); isub = isub + 1;
        imagesc(hca,peak_array_tmp)
        hca.YDir = 'normal';
      end
    end
  end
end
varargout = {1};
