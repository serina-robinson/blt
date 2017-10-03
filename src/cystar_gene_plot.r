#Install packages
#install.packages("genoPlotR")
#require(genoPlotR)
gene_plot<-function(fil){
  packs<-c("genoPlotR","igraph","Biostrings","DECIPHER","phangorn","ggtree","dplyr","tidyr")
  lapply(packs, require, character.only=T)
  
  #Read in the get_dna_segs function
  source("src/get_dna_segs.R")
  
  #Read in the cystargolide gene cluster
  cys<-readAAStringSet(fil)
  ll<-list(cys)
  
  dna<-get_dna_segs(ll)
  dnal<-list(dna)
  dnal[[1]]$strand<-(-1)
  dnal[[1]]$col<-c("gray","orange","slateblue4","red","red","forestgreen","red","hotpink","slateblue4","gray")
  #dnal[[1]]$col<-c("white","gray","dodgerblue","dodgerblue","red","dodgerblue","red","dodgerblue","gray","white")
  
  dnal[[1]]$lwd[7]<-3
  
  mid_pos <- middle(dnal[[1]])
  mid_pos
  lett<-c("orf-1",toupper(letters[1:8]),"orf+1")
  annot<-genoPlotR::annotation(x1=mid_pos,
                               text=lett,
                               rot=0, col="black")
  
  pl<-plot_gene_map(dna_segs = dnal,gene_type="arrows",
                    annotation_height=-20,
                    annotations=annot)
  
  
  colors<-unique(dnal[[1]]$col)[2:length(unique(dnal[[1]]$col))]
  #CysA = orange= 2-IPM synthase, IPM biosynthesis
  #CysB, H = slateblue4 = regulatin/transport
  #CysC, CysD, CysF -> red = AMP-dependent synthetase/ligase
  #CysE -> methylesterase
  #CysG -> methyltransferase
  
  proteins<-c("2-IPM synthase","regulation/transport","ANL superfamily protein","methylesterase","methyltransferase")
  plot.new()
  leg<-legend("bottom",legend=proteins,fill = colors,bty="n")
  
  return(list(pl,leg))
}
