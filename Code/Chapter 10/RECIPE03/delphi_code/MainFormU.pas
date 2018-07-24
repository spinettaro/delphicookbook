unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, CPort, Vcl.WinXCtrls,
  System.ImageList, Vcl.ImgList;

type
  TMainForm = class(TForm)
    ComPort1: TComPort;
    btnSetup: TButton;
    btnConnection: TButton;
    lightBulb1Label: TLabel;
    lightBulb2Label: TLabel;
    lightBulb1Switch: TToggleSwitch;
    lightBulb2Switch: TToggleSwitch;
    procedure btnSetupClick(Sender: TObject);
    procedure btnConnectionClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComPort1RxChar(Sender: TObject; Count: Integer);
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

procedure TMainForm.ComPort1RxChar(Sender: TObject; Count: Integer);
var
  Str: String;
begin
  // Receives messages from Arduino.
  ComPort1.ReadStr(Str, Count);

  if Str.ToUpper = 'L1_ON' then
    lightBulb1Switch.State := TToggleSwitchState.tssOn
  else if Str.ToUpper = 'L1_OFF' then
    lightBulb1Switch.State := TToggleSwitchState.tssOff
  else if Str.ToUpper = 'L2_ON' then
    lightBulb2Switch.State := TToggleSwitchState.tssOn
  else if Str.ToUpper = 'L2_OFF' then
    lightBulb2Switch.State := TToggleSwitchState.tssOff;

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

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if ComPort1.Connected then
    ComPort1.Close;
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
