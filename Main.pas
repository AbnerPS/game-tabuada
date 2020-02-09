unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg;

type
  TFormMain = class(TForm)
    ProgressBar: TProgressBar;
    MainMenu: TMainMenu;
    Timer: TTimer;
    Questoes: TGroupBox;
    LblQuestion: TLabel;
    RadioGroup: TRadioGroup;
    Alternativa1: TRadioButton;
    Alternativa2: TRadioButton;
    Alternativa3: TRadioButton;
    ImageTime: TImage;
    StatusGame: TGroupBox;
    Image1: TImage;
    AlterCorreta: TGroupBox;
    LblCorreta: TLabel;
    Botoes: TGroupBox;
    BtnConfirmar: TButton;
    BtnEncerrar: TButton;
    Dificuldade1: TMenuItem;
    NivelFacil: TMenuItem;
    NivelMedio: TMenuItem;
    NivelDificil: TMenuItem;
    Sobre: TMenuItem;
    MenuIniciar: TMenuItem;
    MenuEncerrar: TMenuItem;
    LblPontos: TLabel;
    procedure MenuIniciarClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure NivelFacilClick(Sender: TObject);
    procedure NivelMedioClick(Sender: TObject);
    procedure NivelDificilClick(Sender: TObject);
    procedure MenuEncerrarClick(Sender: TObject);
    procedure BtnEncerrarClick(Sender: TObject);
    procedure Alternativa1Click(Sender: TObject);
    procedure BtnConfirmarClick(Sender: TObject);
    procedure Alternativa2Click(Sender: TObject);
    procedure Alternativa3Click(Sender: TObject);
    procedure StartGame();
    procedure GameOver();
    procedure SobreClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;
  pontuacao, fator1, fator2, produto, caseAlternativa: Integer;
  flagAlternativa : Integer; //0 = Alternativa 1, 1 = Alternativa 2, 2 = Alternativa 3, 3 = Nenhuma Alternativa
  a, b: Integer; // Variaveis para as alternativas randomicas

implementation

{$R *.dfm}

//------------------------------------------------------------------------------
procedure TFormMain.StartGame();
begin
  ProgressBar.Position := 0; // Inicia a barra de progresso com 0
  flagAlternativa := 3; // Inicia sem nenhuma alternativa correta
  Timer.Enabled := true; // Inicia o jogo (ativa o Timer)
  fator1 := 0; // inicialização neutra
  fator2 := 0; // inicialização neutra
  while (fator1 = 0) or (fator2 = 0) do // gerar novo numero aleatório enquanto fator1 ou fator2 forem iguais á 0
  begin
    fator1 := random(10); // gera um numero aleatorio entre 0 e 10 e atrubui para fator1
    fator2 := random(10); // gera um numero aleatorio entre 0 e 10 e atrubui para fator2
  end;

  produto := fator1 * fator2; // multiplica o fator1 pelo fator2

  caseAlternativa := random(3); // gera um numero aleatorio entre 0 e 2 e atribui para caseAlternativa
  LblQuestion.Caption := IntToStr(fator1)+ ' x ' + IntToStr(fator2) + ' = ?'; // Exibe a questão
  a := 0; // inicialização neutra
  b := 0; // inicialização neutra
  while (a = produto) or (b = produto) or (a = b) do // enquanto qualquer uma das alternativas forem iguais
  begin
    while (a = 0) or (b = 0) do // repetição para gerar um novo valor pra "a" e "b" caso sejam iguais a 0
    begin
      a := random(90); // gerar um outro numero aleatorio para a alternativa
      b := random(90); // gerar um outro numero aleatorio para a alternativa
    end;
  end;
  case caseAlternativa of // case para escolher qual das alternativas será a correta aleatoriamente de acordo com a variavel caseAlternativa e foi atribuido um valor aleatorio entre 0 e 2
  0: begin // se caseAlternativa receber 0 a alternativa correta será a Alternativa 1
    Alternativa1.Caption := '  ' + IntToStr(produto);
    Alternativa2.Caption := '  ' + IntToStr(a);
    Alternativa3.Caption := '  ' + IntToStr(b);
  end;
  1: begin //se caseAlternativa receber 1 a alternativa correta será a Alternativa 2
    Alternativa1.Caption := '  ' + IntToStr(a);
    Alternativa2.Caption := '  ' + IntToStr(produto);
    Alternativa3.Caption := '  ' + IntToStr(b);
  end;
  2: begin //se caseAlternativa receber 2 a alternativa correta será a Alternativa 3
    Alternativa1.Caption := '  ' + IntToStr(a);
    Alternativa2.Caption := '  ' + IntToStr(b);
    Alternativa3.Caption := '  ' + IntToStr(produto);
  end;
  end;

  Alternativa1.Checked := false; // limpa o radiobutton tirando a seleção
  Alternativa2.Checked := false; // limpa o radiobutton tirando a seleção
  Alternativa3.Checked := false; // limpa o radiobutton tirando a seleção
  flagAlternativa := 3; // define como nenhuma alternativa a correta
end;

//------------------------------------------------------------------------------

procedure TFormMain.GameOver(); // metodo de encerramento do jogo
begin
  Timer.Enabled := false;
  ProgressBar.Position := 0;
  LblPontos.Caption := 'Pontuação: 0';
  LblQuestion.Caption := '? x ? = ?';
  LblCorreta.Caption := '? x ? = ?';
  Alternativa1.Caption := '  ?';
  Alternativa2.Caption := '  ?';
  Alternativa3.Caption := '  ?';
  Alternativa1.Checked := false; // limpa o radiobutton tirando a seleção
  Alternativa2.Checked := false; // limpa o radiobutton tirando a seleção
  Alternativa3.Checked := false; // limpa o radiobutton tirando a seleção
  flagAlternativa := 3; // define como nenhuma alternativa a correta
end;

//------------------------------------------------------------------------------

procedure TFormMain.NivelFacilClick(Sender: TObject);
begin
  pontuacao := 0; //Inicia pontuação com 0
  LblPontos.Caption := 'Pontuação: 0'; //Exibe pontuação inicial
  Timer.Enabled := false; // desativa o timer
  Timer.Interval := 300; // define o intervalo do timer para 300 (nível facil)
  StartGame(); // inicializa o jogo
end;

//------------------------------------------------------------------------------

procedure TFormMain.NivelMedioClick(Sender: TObject);
begin
  pontuacao := 0; //Inicia pontuação com 0
  LblPontos.Caption := 'Pontuação: 0'; //Exibe pontuação inicial
  Timer.Enabled := false; // desativa o timer
  Timer.Interval := 100; // define o intervalo do timer para 300 (nível médio)
  StartGame(); // inicializa o jogo
end;

//------------------------------------------------------------------------------

procedure TFormMain.NivelDificilClick(Sender: TObject);
begin
  pontuacao := 0; //Inicia pontuação com 0
  LblPontos.Caption := 'Pontuação: 0'; //Exibe pontuação inicial
  Timer.Enabled := false; // desativa o timer
  Timer.Interval := 20; // define o intervalo do timer para 300 (nível difícil)
  StartGame(); // inicializa o jogo
end;

//------------------------------------------------------------------------------

procedure TFormMain.Alternativa1Click(Sender: TObject);
begin
  flagAlternativa := 0; // usuario escolheu a alternativa 1
end;

//------------------------------------------------------------------------------

procedure TFormMain.Alternativa2Click(Sender: TObject);
begin
  flagAlternativa := 1; // usuario escolheu a alternativa 2
end;

//------------------------------------------------------------------------------

procedure TFormMain.Alternativa3Click(Sender: TObject);
begin
  flagAlternativa := 2; // usuario escolheu a alternativa 3
end;

//------------------------------------------------------------------------------

procedure TFormMain.BtnConfirmarClick(Sender: TObject);
begin
  Timer.Enabled := false;
if ProgressBar.Position <> 0 then //Se o jogo estiver inicializado
begin
  if flagAlternativa = caseAlternativa then // Se acertar a alternativa
  begin
    pontuacao := pontuacao + 1; //Ganha 1 ponto
    LblPontos.Caption := 'Pontuação: ' + IntToStr(pontuacao); //Exibe os pontos
    StartGame();
  end
  else // Se errar a alternativa
  begin
    LblCorreta.Caption :=  IntToStr(fator1)+ ' x ' + IntToStr(fator2) + ' = ' + IntToStr(produto); // caso o usuario erre a alternativa, será exibido a alternativa correta aqui
    Application.MessageBox('  RESPOSTA INCORRETA ',' GAME OVER',MB_OK + MB_DEFBUTTON1 + MB_ICONINFORMATION);
  GameOver(); // encerra o jogo
  end;

end
else //Se o jogo não estiver inicializado
begin
  Application.MessageBox(' JOGO NÃO INICIALIZADO',' ATENÇÃO',MB_OK + MB_DEFBUTTON1 + MB_ICONERROR);
end;

end;

//------------------------------------------------------------------------------

procedure TFormMain.BtnEncerrarClick(Sender: TObject);
begin
if ProgressBar.Position <> 0 then //Se o jogo estiver inicializado
begin
  GameOver(); // encerra o jogo
  Application.MessageBox(' JOGO ENCERRADO','ATENÇÃO',MB_OK + MB_DEFBUTTON1 + MB_ICONWARNING);
end
else //Se o jogo não estiver inicializado
begin
  Application.MessageBox(' JOGO NÃO INICIALIZADO',' ATENÇÃO',MB_OK + MB_DEFBUTTON1 + MB_ICONERROR);
end;
end;

//------------------------------------------------------------------------------

procedure TFormMain.MenuEncerrarClick(Sender: TObject);
begin
if ProgressBar.Position <> 0 then //Se o jogo estiver inicializado
begin
  GameOver(); // encerra o jogo
  Application.MessageBox(' JOGO ENCERRADO','ATENÇÃO',MB_OK + MB_DEFBUTTON1 + MB_ICONWARNING);
end
else //Se o jogo não estiver inicializado
begin
  Application.MessageBox(' JOGO NÃO INICIALIZADO',' ATENÇÃO',MB_OK + MB_DEFBUTTON1 + MB_ICONERROR);
end;
end;

//------------------------------------------------------------------------------

procedure TFormMain.MenuIniciarClick(Sender: TObject);
begin
  pontuacao := 0; //Inicia pontuação com 0
  LblPontos.Caption := 'Pontuação: 0'; //Exibe pontuação inicial
  Timer.Enabled := false; // desativa o timer
  Timer.Interval := 300; // define o intervalo do timer para 300 (nível facil)
  StartGame(); // inicializa o jogo
end;

//------------------------------------------------------------------------------

procedure TFormMain.TimerTimer(Sender: TObject);
begin
if ProgressBar.Position = 100 then // se o tempo acabar
begin
  Timer.Enabled := false; // desativa o timer
  ProgressBar.Position := 0; // zera a barra de progressão
  LblCorreta.Caption :=  IntToStr(fator1)+ ' x ' + IntToStr(fator2) + ' = ' + IntToStr(produto); // caso o usuario erre a alternativa, será exibido a alternativa correta aqui
  Application.MessageBox('  TEMPO ESGOTADO',' GAME OVER',MB_OK + MB_DEFBUTTON1 + MB_ICONINFORMATION);
  GameOver(); // encerra o jogo
end
else
begin
  ProgressBar.Position := ProgressBar.Position + 1; //Carregamento da barra (posição da barra vai de 0 até 100)
end;
end;

//------------------------------------------------------------------------------

procedure TFormMain.SobreClick(Sender: TObject);
begin
if Timer.Enabled = false then // se o jogo não estiver inicializado
begin
Application.MessageBox('  CIÊNCIA DA COMPUTAÇÃO - UNIP' + #13 + #13 + '  APLICAÇÃO DESENVOLVIDA POR:' + #13 + #13 + '  ABNER PEREIRA SILVA                | RA: N215AJ-8' + #13 + '  FELIPE ALVES ALBUQUERQUE   | RA: N131DF-8',' SOBRE',MB_OK + MB_DEFBUTTON1);
end;
end;

end.
