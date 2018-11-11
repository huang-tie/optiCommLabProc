close all;
kkRxParms.bypass       = 0;
kkSigOut               = kkReceiver(rsig, kkRxParms);
bbsig                  = rfDnConv(kkSigOut,rfFreq,Signal.scoperate);
dspsig                 = reSample(bbsig,Signal.scoperate,dsp.fBaud*dsp.sps);
figName                = 'Spectrum';
close(findobj('Name',figName));
fig_response           = figure('Name',figName);
[h_plt1,freq_in_GHz1,amp_in_dB1] = plotSigResp(rsig,2^12,Signal.scoperate);
hold on;
[h_plt2,freq_in_GHz2,amp_in_dB2] = plotSigResp(kkSigOut,2^12,Signal.scoperate,'r-');
hold on;
[h_plt3,freq_in_GHz3,amp_in_dB3] = plotSigResp(bbsig,2^12,Signal.scoperate,'m-');
hold on;
[h_plt4,freq_in_GHz4,amp_in_dB4] = plotSigResp(dspsig,2^12,Signal.scoperate,'k-');
hold off;
legend('beforeKK','afterKK','bbsig','dspsig');
grid on;