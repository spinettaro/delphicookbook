unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, CPort, Vcl.WinXCtrls;

type
  TMainForm = class(TForm)
    lightBulb1Switch: TToggleSwitch;
    ComPort1: TComPort;
    btnSetup: TButton;
    btnConnection: TButton;
    lightBulb1Label: TLabel;
    lightBulb2Label: TLabel;
    lightBulb2Switch: TToggleSwitch;
    procedure btnSetupClick(Sender: TObject);
    procedure lightBulb1SwitchClick(Sender: TObject);
    procedure btnConnectionClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lightBulb2SwitchClick(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateComponentsState;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  System.StrUtils;

{$R *.dfm}

procedure TMainForm.btnSetupClick(Sender: TObject);
begin
  ComPort1.ShowSetupDialog;
end;

procedure TMainForm.btnConnectionClick(Sender: TObject);
begin
  // If the port is connected.
  if ComPort1.Connected then
    ComPort1.Close // Close the port.
  else
    ComPort1.Open; // Open the port.
  UpdateComponentsState;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  UpdateComponentsState;
end;

procedure TMainForm.lightBulb2SwitchClick(Sender: TObject);
begin
  case lightBulb2Switch.State of
    tssOff:
      ComPort1.WriteStr('L2_OFF');
    tssOn:
      ComPort1.WriteStr('L2_ON');
  end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if ComPort1.Connected then
    ComPort1.Close;
end;

procedure TMainForm.lightBulb1SwitchClick(Sender: TObject);
begin
  case lightBulb1Switch.State of
    tssOff:
      ComPort1.WriteStr('L1_OFF');
    tssOn:
      ComPort1.WriteStr('L1_ON');
  end;
end;

procedure TMainForm.UpdateComponentsState;
begin
  lightBulb1Switch.Enabled := ComPort1.Connected;
  lightBulb2Switch.Enabled := ComPort1.Connected;
  lightBulb1Label.Enabled := ComPort1.Connected;
  lightBulb2Label.Enabled := ComPort1.Connected;
  btnConnection.Caption := ifthen(ComPort1.Connected, 'Close', 'Open');
end;

end.
