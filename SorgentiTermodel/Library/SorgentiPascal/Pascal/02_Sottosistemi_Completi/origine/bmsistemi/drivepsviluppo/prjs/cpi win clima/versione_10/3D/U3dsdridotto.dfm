object Form1rid: TForm1rid
  Left = 532
  Top = 33
  Width = 1001
  Height = 807
  Caption = 'Form1rid'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object GLSceneViewer1: TGLSceneViewer
    Left = 0
    Top = 0
    Width = 985
    Height = 769
    Camera = GLCamera1
    Buffer.BackgroundColor = clBlack
    Align = alClient
    OnMouseDown = GLSceneViewer1MouseDown
    OnMouseMove = GLSceneViewer1MouseMove
  end
  object GLScene1: TGLScene
    Left = 24
    Top = 8
    object DCGlobale: TDummyCube
      Direction.Coordinates = {00000000000000800000803F00000000}
      CubeSize = 1
      object DCGenerale: TDummyCube
        Direction.Coordinates = {824A899D0000803F080251B400000000}
        Up.Coordinates = {2EBDBB33080251340000803F00000000}
        CubeSize = 1
        BehavioursData = {0201060B54474C4D6F76656D656E74020008}
        object DCVista: TDummyCube
          CubeSize = 1
          object Cube1: TCube
            Direction.Coordinates = {F304353FFFFFFF3E0000003F00000000}
            Up.Coordinates = {000000BF7A825A3F19F615BE00000000}
            Visible = False
            Material.FrontProperties.Emission.Color = {E7E6E63EE5E4643E000000000000803F}
          end
        end
        object DCOggetti: TDummyCube
          CubeSize = 1
          EdgeColor.Color = {938C0C3E938E0E3F938C0C3E0000803F}
          object DCLuci: TDummyCube
            Direction.Coordinates = {000000002EBDBBB3000080BF00000000}
            Up.Coordinates = {00000000000080BF2EBDBB3300000000}
            CubeSize = 1
            object Sphere1: TSphere
              Position.Coordinates = {000000000000803F0000803F0000803F}
              Scale.Coordinates = {CDCCCC3DCDCCCC3DCDCCCC3D00000000}
              Visible = False
              Material.FrontProperties.Ambient.Color = {0000000000000000000000000000803F}
              Material.FrontProperties.Diffuse.Color = {0000000000000000000000000000803F}
              Material.FrontProperties.Emission.Color = {0000803F0000803F0000803F0000803F}
              Radius = 0.5
              object Disk1: TDisk
                OuterRadius = 0.5
                SweepAngle = 360
              end
              object Cylinder1: TCylinder
                BottomRadius = 0.5
                Height = 1
                TopRadius = 0.5
              end
            end
          end
          object DcParticles: TDummyCube
            CubeSize = 1
          end
          object Cube2: TCube
            Direction.Coordinates = {F304353FFFFFFF3E0000003F00000000}
            Up.Coordinates = {000000BF7A825A3F19F615BE00000000}
            Visible = False
            Material.FrontProperties.Ambient.Color = {BFBEBE3E9F9E1E3F9392923E0000803F}
            Material.FrontProperties.Diffuse.Color = {DFDEDE3EEBEAEA3EF7F6F63ECDCC2C3F}
            Material.FrontProperties.Emission.Color = {CFCECE3EE3E2E23EEBEAEA3E0000803F}
            Material.FrontProperties.Specular.Color = {00000000000000000000000046B6733F}
            Material.BlendingMode = bmTransparency
          end
        end
      end
    end
    object GLCamera1: TGLCamera
      DepthOfView = 100
      FocalLength = 100
      TargetObject = DCVista
      Position.Coordinates = {00000000000040400000A0C00000803F}
      Up.Coordinates = {000000800000803F0000000000000000}
      object GLLightSource1: TGLLightSource
        ConstAttenuation = 1
        SpotCutOff = 180
      end
    end
  end
end
