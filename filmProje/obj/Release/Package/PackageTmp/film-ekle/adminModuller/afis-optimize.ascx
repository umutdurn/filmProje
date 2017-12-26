<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="afis-optimize.ascx.cs" Inherits="filmProje.film_ekle.adminModuller.afis_optimize" %>
<div class="g_6 contents_header">
 	<h3 class="i_16_dashboard tab_label">Afiş Optimize</h3>
 	<div><span class="label">Afişleri Optimize Et</span></div>
 </div>
 <div class="g_6 contents_options">
 	<div class="simple_buttons">
 		<div class="bwIcon i_16_help">Help</div>
 	</div>
 	<div class="simple_buttons">
 		<div class="bwIcon i_16_settings">Settings</div>
 		<div class="buttons_arrow">
 			<!-- Drop Menu -->
 			<ul class="drop_menu menu_with_icons right_direction">
              <li>
  	            <a class="i_16_add" href="#" title="New Flie">
  		            <span class="label">New File</span>
  	            </a>  	
              </li>
              <li>
  	            <a class="i_16_progress" href="#" title="2 Files Left">
  		            <span class="label">Files Left</span>
  		            <span class="small_count">2</span>
  	            </a>
              </li>
              <li>
  	            <a class="i_16_files" href="#" title="Browse Files">
  		            <span class="label">Browse Files</span>
  	            </a>
              </li>
 			</ul>
 		</div>
 	</div>
 </div>
<div class="g_12 separator"><span></span></div>
<div class="g_12">
    <div class="widget_header">
	    <h4 class="widget_header_title wwIcon i_16_forms">Afişleri Optimize Et</h4>
    </div>
    <div class="widget_contents noPadding">
	    <div class="line_grid">
            <asp:Button ID="btnOptimize" runat="server" Text="Upload Klasörünü Optimize Et" OnClick="btnOptimize_Click" />
	    </div>
    </div>
</div>
