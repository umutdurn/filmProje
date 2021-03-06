﻿<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="filmProje._Default" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>
<asp:Content ID="headBolum" ContentPlaceHolderID="headContent" runat="server">
    <meta http-equiv="refresh" content="120"/>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="row">
    <asp:Repeater ID="filmler" runat="server">
        <ItemTemplate>
            <div class="col s6 m4 l4 filmrelative">
                <asp:Panel ID="pnlYakinda" runat="server" Visible='<%#Convert.ToInt32(Eval("Gelecek")) == 1 %>' CssClass="filmustResim">
                    <a href="film/<%#Eval("URL") %>" title="<%#Eval("OrjinalAdi") %> izle"><img src="<%=Page.ResolveUrl("~") %>images/yakinda.png" alt="Gelecek Film - <%#Eval("OrjinalAdi") %>" title="Gelecek Film - <%#Eval("OrjinalAdi") %>" width="102" height="102" /></a>
                </asp:Panel>
                <div class="filmafis">
                    <a href="film/<%#Eval("URL") %>" title="<%#Eval("OrjinalAdi") %> izle"><img src="<%=Page.ResolveUrl("~") %>images/upload/<%#Eval("Poster") %>?width=216&height=320&mode=max&quality=60" width="216" height="320" class="hoverable width100" alt="<%#Eval("Baslik") %>" title="<%#Eval("Baslik") %>"></a>
                    <div class="filmaltbilgi">
                        <div class="filmimdb">
                            IMDB Puanı: <%#Eval("IMDB") %> /10
                        </div>
                        <div class="filmbaslik">
                            <a href="film/<%#Eval("URL") %>" title="<%#Eval("OrjinalAdi") %> izle"><%#Eval("Baslik") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>
<div class="sayfalamay">
    <cc1:CollectionPager ID="CollectionPager1" runat="server" ShowPageNumbers="True" LabelText="" ControlCssClass="sayfalamayeni" PageSize="15" NextText="Sonraki" LastText="Son" BackText="Önceki" FirstText="İlk" ResultsFormat="" BackNextDisplay="HyperLinks" BackNextLocation="Split" BackNextStyle="margin:0px 15px" MaxPages="999999" PageNumbersDisplay="Numbers" ShowFirstLast="False"></cc1:CollectionPager>
    <div class="clear"></div>
</div>
</asp:Content>
