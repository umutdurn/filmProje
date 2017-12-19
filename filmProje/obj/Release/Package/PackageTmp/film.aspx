<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="film.aspx.cs" Inherits="filmProje.film" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="updIcerik" runat="server">
        <ContentTemplate>
            <div itemscope itemtype="http://schema.org/Movie">
                <h1 class="filmanabaslik"><asp:Literal ID="ltrFilmAdi" runat="server"></asp:Literal></h1>
                <div class="orjinalAdi">Orjinal Adı: <strong><span itemprop="name"><asp:Literal ID="ltrOrjinalAdi" runat="server"></asp:Literal></span></strong></div>
                <asp:DropDownList ID="dropPartlar" runat="server" AutoPostBack="true" OnSelectedIndexChanged="dropPartlar_SelectedIndexChanged"></asp:DropDownList>
                <asp:Repeater ID="rptfilm" runat="server" OnItemCommand="rptfilm_ItemCommand">
                    <ItemTemplate>
                            <meta itemprop="image" content="http://<%=Request.Url.Host.ToLower() %>/images/upload/<%#Eval("Poster") %>">
                            <meta itemprop="dateCreated" content="<%#String.Format("{0:yyy-MM-dd}", Convert.ToDateTime(Eval("OlusturmaTarihi")))%>">
                            <meta itemprop="inLanguage" content="tr">
                            <div class="iframePart">
                                <asp:Literal ID="ltrIframe" runat="server"></asp:Literal>
                            </div>
                            <div class="filmbilgileri">
                                <h4 class="filmkonubaslik"><%#Eval("OrjinalAdi") %> Bilgileri</h4>
                                <div class="row">
                                    <div class="col l3 hide-on-med-and-down">
                                        <img src="<%=Page.ResolveUrl("~") %>images/upload/<%#Eval("Poster") %>" title="<%#Eval("OrjinalAdi") %>" alt="<%#Eval("OrjinalAdi") %>" />
                                    </div>
                                    <div class="col s12 m12 l9 fbilgiler">
                                        <div class="oykullan">
                                            <div class="col s12 m3 l3 fbilgi">Filme Oy Ver <span class="right hide-on-med-and-down">:</span></div>
                                            <div class="col s12 m9 l9">
                                                <asp:UpdatePanel ID="uptOyKullan" runat="server">
                                                    <ContentTemplate>
                                                        <div class="yildizler">
                                                            <asp:Panel ID="pnlYildizKapa" Visible="false" CssClass="yildizKapa" runat="server"></asp:Panel>
                                                            <asp:Button ID="yldz1" runat="server" CssClass="yildiz1" CommandName="yildizver" CommandArgument="1" />
                                                            <asp:Button ID="yldz2" runat="server" CssClass="yildiz2" CommandName="yildizver" CommandArgument="2" />
                                                            <asp:Button ID="yldz3" runat="server" CssClass="yildiz3" CommandName="yildizver" CommandArgument="3" />
                                                            <asp:Button ID="yldz4" runat="server" CssClass="yildiz4" CommandName="yildizver" CommandArgument="4" />
                                                            <asp:Button ID="yldz5" runat="server" CssClass="yildiz5" CommandName="yildizver" CommandArgument="5"/>
                                                            <asp:Label ID="lbloyKullandin" runat="server" Text=""></asp:Label>
                                                            <div class="clear"></div>
                                                        </div>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </div>
                                        </div>
                                        <div class="clear"></div>
                                        <div class="imdb">
                                            <div class="col s12 m3 l3 fbilgi">Oy İstatistiği <span class="right hide-on-med-and-down">:</span></div>
                                            <div class="col s12 m9 l9" itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating">
                                                <div>
						                            <span itemprop="ratingValue"><%=ratingGetir() %></span>/<span itemprop="bestRating">10</span> - <span itemprop="ratingCount"><%=ratCount() %></span> oy kullanıldı. <span itemprop="reviewCount"><%#Eval("Inceleme").ToString() == "" ? "0" : Eval("Inceleme") %></span> görüntüleme.
					                            </div>
                                            </div>
                                        </div>
                                        <div class="clear"></div>
                                        <div class="imdb">
                                            <div class="col s12 m3 l3 fbilgi">IMDB Puanı <span class="right hide-on-med-and-down">:</span></div>
                                            <div class="col s12 m9 l9"><%#Eval("IMDB") %></div>
                                        </div>
                                        <div class="clear"></div>
                                        <div class="yapimyili">
                                            <div class="col s12 m3 l3 fbilgi">Yapım Yılı <span class="right hide-on-med-and-down">:</span></div>
                                            <div class="col s12 m9 l9"><a href="<%=Page.ResolveUrl("~/yapim-yili/") %><%#Eval("YapimYili") %>"><%#Eval("YapimYili") %></a></div>
                                        </div>
                                        <div class="clear"></div>
                                        <div class="ulke">
                                            <div class="col s12 m3 l3 fbilgi">Yapım Ülkesi <span class="right hide-on-med-and-down">:</span></div>
                                            <div class="col s12 m9 l9"><a href="<%=Page.ResolveUrl("~/ulke/") %><%#Eval("Ulke") %>"><%#ulkeGetir(Eval("Ulke").ToString()) %></a></div>
                                        </div>
                                        <div class="clear"></div>
                                        <div class="sure"> 
                                            <div class="col s12 m3 l3 fbilgi">Film Süresi <span class="right hide-on-med-and-down">:</span></div>
                                            <div class="col s12 m9 l9"><%#Eval("Sure") %> Dk</div>
                                        </div>
                                        <div class="clear"></div>
                                        <div class="kategoriler">
                                            <div class="col s12 m3 l3 fbilgi">Kategoriler <span class="right hide-on-med-and-down">:</span></div>
                                            <div class="col s12 m9 l9"><%#kategoriGetir(Eval("Kategoriler").ToString()) %></div>
                                        </div>
                                        <div class="clear"></div>
                                        <div class="yonetmenler">
                                            <div class="col s12 m3 l3 fbilgi">Yönetmenler <span class="right hide-on-med-and-down">:</span></div>
                                            <div class="col s12 m9 l9"><%#yonetmenGetir(Eval("Yonetmenler").ToString()) %></div>
                                        </div>
                                        <div class="clear"></div>
                                        <div class="oyuncular">
                                            <div class="col s12 m3 l3 fbilgi">Oyuncular <span class="right hide-on-med-and-down">:</span></div>
                                            <div class="col s12 m9 l9"><%#oyuncuGetir(Eval("Oyuncular").ToString()) %></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="filmicerik">
                                <h4 class="filmkonubaslik"><%#Eval("OrjinalAdi") %> Konusu</h4>
                                <div itemprop="description">
                                    <%#Eval("Icerik") %>
                                </div>
                            </div>
                    </ItemTemplate>
                </asp:Repeater>
                <div class="filmyorumyap">
                    <h4 class="filmkonubaslik"><span itemprop="name"><asp:Literal ID="ltrFilmAdiYorum" runat="server"></asp:Literal> Filmi Yorumları</h4>
                    <div class="col s12 m12 l6">
                        <asp:TextBox ID="txtYorumAdi" MaxLength="30" CssClass="input-field" placeholder="Adınız" runat="server"></asp:TextBox>
                    </div>
                    <div class="col s12 m12 l6">
                        <asp:TextBox ID="txtYorumEmail" CssClass="input-field" placeholder="E-Mail Adresiniz" runat="server"></asp:TextBox>
                    </div>
                    <div class="col s12 m12 l12">
                        <asp:TextBox ID="txtYorum" MaxLength="200" CssClass="materialize-textarea" data-lenght="200" TextMode="MultiLine" placeholder="Yorumunuz" runat="server"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnYorumYap" runat="server" Text="Yorum Yap" CssClass="waves-effect waves-light btn left width100" OnClick="btnYorumYap_Click"></asp:Button>
                    <span class="label"><asp:Literal ID="ltrYorum" runat="server" Text="Not: HTML kodlarına izin verilmemektedir."></asp:Literal></span>
                    <div class="clear"></div>
                </div>
                <div class="filmyorumlari">
                    <div class="toplamYorum">
                        Bu filme ait <span><asp:Literal ID="ltrYorumSayi" runat="server"></asp:Literal></span> yorum bulundu. Sizlerde diğer izleyicilerimize fikir vermek adına filme yorumda bulunabilirsiniz.
                    </div>
                    <asp:Repeater ID="rptFilmYorumlar" runat="server">
                        <ItemTemplate>
                            <div class="filmYorumu">
                                <div class="yorumYazari">
                                    <%#Eval("Nick") %>
                                </div>
                                <div class="right">
                                    <%#zaman(Convert.ToDateTime(Eval("YorumTarih"))) %>
                                </div>
                                <div class="clear"></div>
                                <div class="yorumText">
                                    <%#Eval("Yorum") %>
                                </div>
                            </div>
                            <hr />
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <script type="text/javascript">

        $(document).ready(function(){
			var kontrol=0;
			$(".yildizler input").mouseover(function () {
					var index=$(this).index();
					for(i=index;i>=0;i--){
					    $(".yildizler input:eq(" + i + ")").addClass("yildizhover");
					}
			})
			$(".yildizler input").mouseout(function () {
				if(kontrol==0){
				    $(".yildizler input").removeClass("yildizhover");
				}
			})
		})

	</script>
</asp:Content>
