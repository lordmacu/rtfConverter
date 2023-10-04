

/// Removes specified RTF keywords and their accompanying commands
/// from a given RTF string. Also, replaces special sequences with
/// their Unicode equivalent characters.
/// 
/// @param inputText The original RTF string.
/// @param keywords A list of RTF keywords to remove.
/// @return A cleaned string without the specified RTF keywords and commands.
String removeRtfKeywords(String inputText, List<String> keywords) {
  String cleanedText = inputText;

  // Iterate over each keyword
  for (String keyword in keywords) {
    // Escape any special characters in the keyword
    String escapedKeyword = RegExp.escape(keyword);

    // Create the regular expression to find the keyword and its commands
    RegExp regExp = RegExp(r"\\(" + escapedKeyword + r")([^\s\\{}]*|\s?)");

    // Replace occurrences of the keyword and its commands in the text
    cleanedText = cleanedText.replaceAll(regExp, '');
  }

  // Replace special sequences with their Unicode equivalent characters
  cleanedText = cleanedText.replaceAll(r"\'e1", "á");
  cleanedText = cleanedText.replaceAll(r"\'e9", "é");
  cleanedText = cleanedText.replaceAll(r"\'ed", "í");
  cleanedText = cleanedText.replaceAll(r"\'f3", "ó");
  cleanedText = cleanedText.replaceAll(r"\'fa", "ú");
  cleanedText = cleanedText.replaceAll(r"\'fc", "ü");
  cleanedText = cleanedText.replaceAll(r"\'c1", "Á");
  cleanedText = cleanedText.replaceAll(r"\'c9", "É");
  cleanedText = cleanedText.replaceAll(r"\'cd", "Í");
  cleanedText = cleanedText.replaceAll(r"\'d3", "Ó");
  cleanedText = cleanedText.replaceAll(r"\'da", "Ú");
  cleanedText = cleanedText.replaceAll(r"\'bf", "¿");
  cleanedText = cleanedText.replaceAll(r"\'f1", "ñ");
  cleanedText = cleanedText.replaceAll(r"\'d1", "Ñ");
  cleanedText = cleanedText.replaceAll(r"\'a1", "¡");
  cleanedText = cleanedText.replaceAll(r"\'ab", "«");
  cleanedText = cleanedText.replaceAll(r"\'bb", "»");

  // Remove inline annotations like { [a]}, { [b]} etc.
  cleanedText = cleanedText.replaceAll(RegExp(r'\{\s?\[[a-zA-Z0-9]+\]\}'), '');

  // Add more replacements as needed

  return cleanedText;
}

void main() {
  // List of RTF keywords to remove
  List<String> rtfKeywords = ["rtf","ansi","mac","pc","pca","ansicpg","deff","deflang","deflangfe","adeflang","adeflangfe","paperw","paperh","margl","margr","margt","margb","landscape","portrait","sectd","titlepg","facingp","rtlgutter","viewkind","vieww","viewh","viewscale","pgnstart","pgnrestart","pgncont","pgnx","pgny","pgnh","pgwsxn","pghsxn","marglsxn","margrsxn","margtsxn","margbsxn","guttersxn","f","fs","fnil","froman","fswiss","fmodern","fscript","fdecor","ftech","fbidi","fcharset","cf","cb","cpg","expnd","expndtw","kerning","b","i","ul","ulnone","ulw","uld","uldb","ulth","ulthd","ulthdash","ulthdashd","ulthdashdd","strike","sub","super","nosupersub","scaps","outl","shad","v","fsxx","dn","highlight","uldash","uldashd","uldashdd","ulwave","ulhwave","ululdbwave","plain","embo","caps","nospace","lang","langfe","langnp","langfenp","noproof","stshdbch","stshfloch","stshfhich","stshfbi","par","pard","li","fi","ri","rin","line","ql","qr","qj","qc","sb","sa","sbk","pagebb","sl","slmult","pararsid","linex","brdrb","brdrs","brdrl","brdrt","brsp","tx","ltrpar","rtlpar","ab","absh","dcs","faauto","fahang","favar","fj","adjustright","keep","keepn","level","nosnap","nowwrap","shading","sect","sbknone","sbkcol","sbkpage","pgnstart","pgnrestart","pgncont","pgnx","pgny","pgnh","pgwsxn","pghsxn","marglsxn","margrsxn","margtsxn","margbsxn","guttersxn","ltrsect","rtlsect","sectunlocked","sectd","linemod","linex","line","linecont","linestart","linerestart","linestarts","linerestarts","linetts","linettm","lineppage","linebpage","trowd","cell","row","intbl","irow","irowband","trql","trqr","trqc","trrh","trleft","cellx","clmgf","clmrg","clvmgf","clvmrg","clvertalt","clvertalc","clvertalb","cltxlrtb","cltxbtlr","cltxtbrl","cltxlrtbv","cltxtbrlv","trbrdrb","trbrdrl","trbrdrr","trbrdrt","clbrdrb","clbrdrl","clbrdrr","clbrdrt","brdrtbl","brdrnil","clpadl","clpadt","clpadr","clpadb","cellpaddl","cellpaddt","cellpaddr","cellpadb","clshdng","clcfpat","clcbpat","ls","li","fi","pn","pnlvl","ilvl","listtext","list","listtable","listname","listid","listoverride","listoverridetable","pnstart","pnindent","pndec","pnlcltr","pnlcrm","pnf","pni","pnstrike","pncf","pnseclvl","pnrauth","pnrdate","pnrnot","pnrrgb","pnrpnbrk","colortbl","red","green","blue","tab","lquote","rquote","ldblquote","rdblquote","emdash","endash","bullet","~","lbr","rbr","zwbo","zwj","zwnbo","zwnj","object","pict","shp","shptxt","shprslt","shpz","sp","sn","sv","objemb","objlink","objautlink","objsub","objpub","objicemb","objhtml","objocx","u","uc","ucl","ud","info","author","creatim","revtim","version","vern","edmins","nofpages","nofwords","nofchars","nofcharsws","id","operator","category","manager","company","doccomm","hlinkbase","title","subject","keywords","comment","vern","docnofastaves","*","\\","{","}","nonesttables","nesttableprops","nestrow","nestcell","row","cell","intbl","nest","nonesttables","shpinst","shpgrp","shpwr","shpfhdr","xe","tc","txe","bkmkstart","bkmkend","field","fldinst","fldrslt","datafield","formfield","formfield","ffname","ffdeftext","ffformat","ffhelptext","ffstattext"] ;

  // Original RTF string
  String text = r"\'bfNo les ense\'f1a el mismo orden natural de las cosas que es una verg\'fcenza para el hombre dejarse crecer el cabello,";

  // Clean the RTF string
  String cleanedText = removeRtfKeywords(text, rtfKeywords);

  print("Original: $text");
  print("Modified: $cleanedText");
}
