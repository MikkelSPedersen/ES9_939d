classdef PID_Class < handle
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        Kp
        Ki
        Kd
        N
        T
        p_err = 0
        pp_err = 0
        p_u = 0
        pp_u = 0
        term1 = 0
        term2 = 0
        term3 = 0
        term4 = 0
        term5 = 0
        Saturation = 0
    end

    methods
        function obj = PID_Class(Kp,Ki,Kd,N,T,Saturation)
            %UNTITLED5 Construct an instance of this class
            %   Detailed explanation goes here
            obj.Kp = Kp;
            obj.Ki = Ki;
            obj.Kd = Kd;
            obj.N = N;
            obj.T = T;
            if (Ki > 0)
                obj.term1 = ((4+2*N*T)*Kp + (2*T+N*T^2)*Ki + 4*N*Kd)/(4+2*N*T);
                obj.term2 = (-8*Kp+2*N*T^2*Ki-8*N*Kd)/(4+2*N*T);
                obj.term3 = ((4-2*N*T)*Kp+(N*T^2-2*T)*Ki+4*N*Kd)/(4+2*N*T);
                obj.term4 = (8)/(4+2*N*T);
                obj.term5 = -(4-2*N*T)/(4+2*N*T);
            elseif(Kd > 0)
                obj.term1 = ((2+N*T)*Kp+2*N*Kd)/(2+N*T);
                obj.term2 = ((N*T-2)*Kp-2*N*Kd)/(2+N*T);
                obj.term4 = -(N*T-2)/(2+N*T);
            else
                obj.term1 = Kp;
            end
            obj.Saturation = Saturation;
        end

        function newU = Calculate(obj,current_error)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here

            if(sign(current_error) ~= sign(obj.p_err))
                obj.p_u = 0;
                obj.pp_u = 0;
           
            end
            
            newU = obj.term1* current_error + obj.term2*obj.p_err + obj.term3*obj.pp_err+obj.term4*obj.p_u+obj.term5*obj.pp_u;

            if (obj.Saturation > 0 && abs(newU) > obj.Saturation)
                newU = sign(newU)*obj.Saturation;
            end

            obj.pp_err = obj.p_err;
            obj.p_err = current_error;
            obj.pp_u = obj.p_u;
            obj.p_u = newU;
            
        end
    end
end