<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="film.aspx.cs" Inherits="filmProje.film" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div id="siyahBack" class="bckKapali"></div>
    <asp:UpdatePanel ID="updIcerik" runat="server">
        <ContentTemplate>
            <div itemscope itemtype="http://schema.org/Movie">
                <h1 class="filmanabaslik"><a href="<%=Request.RawUrl %>" title="<%=filmAdi() %>"><asp:Literal ID="ltrFilmAdi" runat="server"></asp:Literal></a></h1>
                <div class="orjinalAdi">Orjinal Adı: <strong><span itemprop="name"><asp:Literal ID="ltrOrjinalAdi" runat="server"></asp:Literal></span></strong></div>
                <div id="partSec">
                    <asp:Repeater ID="rptPartlar" runat="server">
                        <ItemTemplate>
                            <a href="<%#UrlGetir(Container.ItemIndex+"_"+Eval("Dil").ToString()) %>" title="<%#Eval("Dil") %>" class="waves-effect waves-light btn partbtnpadding <%#Eval("Dil").ToString() == "Fragman" ? "fragmanpart" : "" %>"><%#Eval("PartAdi") %></a>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <asp:Repeater ID="rptfilm" runat="server" OnItemCommand="rptfilm_ItemCommand">
                    <ItemTemplate>
                            <meta itemprop="image" content="http://<%=Request.Url.Host.ToLower() %>/images/upload/<%#Eval("Poster") %>">
                            <meta itemprop="dateCreated" content="<%#String.Format("{0:yyy-MM-dd}", Convert.ToDateTime(Eval("OlusturmaTarihi")))%>">
                            <meta itemprop="inLanguage" content="tr">
                            <div class="iframePart">
                                <div id="videoOnu" class="yukleniyor">
                                     <div class="progress">
                                        <div class="indeterminate"></div>
                                     </div>
                                    <span>Film yüklenirken lütfen bekleyin. <br /> Fragmanı geçmek için film yüklenirken "Part" seçebilirsiniz.</span>
                                </div>
                                <asp:Literal ID="ltrIframe" runat="server"></asp:Literal>
                            </div>
                            <div class="filmbilgileri">
                                <h4 class="filmkonubaslik"><%#Eval("OrjinalAdi") %> Bilgileri</h4>
                                <div class="row">
                                    <div class="col l3 hide-on-med-and-down filmrelative">
                                        <asp:Panel ID="pnlYakinda" runat="server" Visible='<%#Convert.ToInt32(Eval("Gelecek")) == 1 %>' CssClass="filmustResimFilmIci">
                                            <img src="<%=Page.ResolveUrl("~") %>images/yakinda.png" alt="Gelecek Film - <%#Eval("OrjinalAdi") %>" title="Gelecek Film - <%#Eval("OrjinalAdi") %>"/>
                                        </asp:Panel>
                                        <img src="<%=Page.ResolveUrl("~") %>images/upload/<%#Eval("Poster") %>?width=156&height=224&mode=max&quality=60" title="<%#Eval("OrjinalAdi") %> izle" alt="<%#Eval("OrjinalAdi") %>" />
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
                                <div itemprop="description" class="kismiAciklama" id="filmAciklamasi">
                                    <%#Eval("Icerik") %>
                                </div>
                                <div class="aciklamaDevami">
                                    <span class="devaminiGor">Tüm Yazıyı Gör >></span>
                                </div>
                            </div>
                    </ItemTemplate>
                </asp:Repeater>
                <div class="filmyorumyap">
                    <h4 class="filmkonubaslik"><asp:Literal ID="ltrFilmAdiYorum" runat="server"></asp:Literal> Filmi Yorumları</h4>
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
    <script>
        function pageLoad(sender, args) {
            $(document).ready(function () {
                var kontrol = 0;
                $(".yildizler input").mouseover(function () {
                    var index = $(this).index();
                    for (i = index; i >= 0; i--) {
                        $(".yildizler input:eq(" + i + ")").addClass("yildizhover");
                    }
                })
                $(".yildizler input").mouseout(function () {
                    if (kontrol == 0) {
                        $(".yildizler input").removeClass("yildizhover");
                    }
                })
            })
            $(document).ready(function () {

                $(".aciklamaDevami").click(function () {
                    if ($("#filmAciklamasi").hasClass("kismiAciklama")) {
                        $("#filmAciklamasi").removeClass("kismiAciklama").addClass("tamAciklama");
                        $(".aciklamaDevami").addClass("heightSifir");
                    }
                });

                function explode() {

                    $("#videoOnu").addClass("kapat");

                }
                setTimeout(explode, 4000);
            });
        }
	</script>
</asp:Content>
