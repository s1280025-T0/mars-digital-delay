classdef SDFtest_vst_v2 < audioPlugin
    properties
        Freq_F1 = sqrt(20*500)
        Speed_F1 = 0
        Freq_F2 = sqrt(3e3*20e3)
        Speed_F2 = 0
        Distance = 1
        DelayMode = 'Linear'
        Enable = true
    end
    properties (Constant)
        PluginInterface = audioPluginInterface( ...
            audioPluginParameter('Freq_F1', ...
            'Label','Hz', ...
            'Mapping',{'log',20,2200}), ...
            audioPluginParameter('Speed_F1', ...
            'Label','m/s', ...
            'Mapping',{'lin',-20,20}), ...
            audioPluginParameter('Freq_F2', ...
            'Label','Hz', ...
            'Mapping',{'log',2201,22000}), ...
            audioPluginParameter('Speed_F2', ...
            'Label','m/s', ...
            'Mapping',{'lin',-20,20}), ...
            audioPluginParameter('Distance', ...
            'DisplayName', 'Distance', ...
            'Label', 'm', ...
            'Mapping',{'log',0.1,3}, ...
            'Style','hslider'), ...
            audioPluginParameter('DelayMode', ...
            'DisplayName', 'Delay Mode', ...
            'Mapping',{'enum','Linear', 'Logarithmic', 'Sigmoid', 'Stepwise'}), ...
            audioPluginParameter('Enable'))
    end
    properties (Access = private)
        pFractionalDelay
    end
    methods
        % ----constructor----
        function plugin = SDFtest_vst_v2
            plugin.pFractionalDelay = dsp.VariableFractionalDelay(...
                'MaximumDelay',65000);
        end
        % ----main----
        function out = process(plugin, in)
            % config
            % fs = plugin.pSR;
            numSamples = size(in,1);
            % delayInSamples = plugin.Distance*44100;
            delaySamples = 100;

            [d1, d2] = size(in); % delayed vectors
            delayVector = [20000 12000];
            if plugin.Enable
                % out = step(plugin.pFractionalDelay, in);
                % out = out*addDelay(plugin, in);
                out = plugin.pFractionalDelay(in,delayVector);
            else
                out = in;
            end
        end
        % ---reset----
        % when sampling rate changes
        function reset(plugin)
            % plugin.pFractionalDelay.SampleRate = getSampleRate(plugin);
            reset(plugin.pFractionalDelay);
        end
        % ----parameter modification----
        % function set.Freq_F1(plugin,val)
        %     plugin.Freq_F1 = val;
        %     plugin.mPEQ.Frequencies(1) = val; %#ok<*MCSUP>
        % end
        % function set.Speed_F1(plugin,val)
        %     plugin.Speed_F1 = val;
        %     plugin.mPEQ.PeakGains(1) = val;
        % end
        % function set.Freq_F2(plugin,val)
        %     plugin.Freq_F2 = val;
        %     plugin.mPEQ.Frequencies(3) = val;
        % end
        % function set.Speed_F2(plugin,val)
        %     plugin.Speed_F2 = val;
        %     plugin.mPEQ.PeakGains(3) = val;
        % end
        % function y = addDelay(plugin)
        %     y = plugin.Distance;
        % end
    end
end