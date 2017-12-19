<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="filmProje.film_ekle._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Serifilmizler.com Yönetim Girişi</title>
    <link href="CSS/login.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="login-page">
      <div class="form">
        <div class="login-form">
            <asp:TextBox ID="txtEmail" placeholder="E-mail" runat="server"></asp:TextBox>
            <asp:TextBox ID="txtParola" placeholder="Parola" TextMode="Password" runat="server"></asp:TextBox>
            <asp:Button ID="btnGiris" runat="server" Text="Giriş Yap" OnClick="btnGiris_Click" />
            <asp:Label ID="lblGirisHata" runat="server" Text=""></asp:Label>
        </div>
      </div>
    </div>
    </form>
</body>
</html>
