<%@ Page Title="" Language="C#" MasterPageFile="~/film-ekle/yonetim.Master" AutoEventWireup="true" CodeBehind="yonetim.aspx.cs" Inherits="filmProje.film_ekle.yonetim1" %>

<%@ Register Src="~/film-ekle/adminModuller/film-ekle.ascx" TagPrefix="uc1" TagName="filmekle" %>
<%@ Register Src="~/film-ekle/adminModuller/kategoriler.ascx" TagPrefix="uc1" TagName="kategoriler" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/ckeditor/adapters/jquery.js"></script>
    <script src="../Scripts/ckeditor/ckeditor.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="AnaPanel" runat="server">
        <asp:Panel ID="pnlfilmlistele" runat="server" Visible="false"></asp:Panel>
        <asp:Panel ID="pnlfilmekle" runat="server" Visible="false">
            <uc1:filmekle runat="server" id="filmekle" />
        </asp:Panel>
        <asp:Panel ID="pnlkategoriekle" runat="server" Visible="false">
            <uc1:kategoriler runat="server" id="kategoriler" />
        </asp:Panel>
    </asp:Panel>
</asp:Content>
