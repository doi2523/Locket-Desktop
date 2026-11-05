import * as React from 'react';

export interface SideRaysProps {
  rayColor1?: string;
  rayColor2?: string;
  origin?: 'top-right' | 'top-left' | 'bottom-right' | 'bottom-left' | 'right' | 'left';
  speed?: number;
  intensity?: number;
  spread?: number;
  density?: number;
  sharpness?: number;
  falloff?: number;
  glow?: number;
  saturation?: number;
  dust?: number;
  opacity?: number;
  light?: boolean;
  tilt?: number;
  followMouse?: boolean;
  mouseAim?: number;
  mouseSpread?: number;
  mousePower?: number;
  className?: string;
  style?: React.CSSProperties;
}

declare const SideRays: React.FC<SideRaysProps>;

export default SideRays;

