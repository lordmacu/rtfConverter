/**
 * Remove specified RTF keywords and their accompanying commands from an RTF string.
 * Also replaces special character sequences with their Unicode equivalent.
 * 
 * @param {string} inputText - The original RTF string.
 * @param {Array<string>} keywords - List of RTF keywords to remove.
 * @return {string} - The cleaned string.
 */
function removeRtfKeywords(inputText, keywords) {
  let cleanedText = inputText;

  keywords.forEach((keyword) => {
    // Escape special characters in the keyword
    const escapedKeyword = keyword.replace(/[.*+\-?^${}()|[\]\\]/g, '\\$&');

    // Create the regular expression
    const regExp = new RegExp(`\\\\(${escapedKeyword})([^\\s\\\\{}]*)\\s?`, 'g');

    // Replace in the text
    cleanedText = cleanedText.replace(regExp, '');
  });

  // Convert special sequences to their Unicode equivalent
  const specialCharsMap = {
    "\\'e1": 'á',
    "\\'e9": 'é',
    "\\'ed": 'í',
    "\\'f3": 'ó',
    "\\'fa": 'ú',
    "\\'c1": 'Á',
    "\\'c9": 'É',
    "\\'cd": 'Í',
    "\\'d3": 'Ó',
    "\\'da": 'Ú',
    "\\'bf": '¿',
    "\\'f1": 'ñ',
    "\\'d1": 'Ñ',
    "\\'a1": '¡',
    "\\'ab": '«',
    "\\'bb": '»',
    "{ \\[a-zA-Z]}": ''
  };

  Object.keys(specialCharsMap).forEach((key) => {
    const regExp = new RegExp(key, 'g');
    cleanedText = cleanedText.replace(regExp, specialCharsMap[key]);
  });

  return cleanedText;
}

// Usage example
const rtfKeywords = ["rtf","ansi","mac","pc","pca","ansicpg","deff","deflang","deflangfe","adeflang","adeflangfe","paperw","paperh","margl","margr","margt","margb","landscape","portrait","sectd","titlepg","facingp","rtlgutter","viewkind","vieww","viewh","viewscale","pgnstart","pgnrestart","pgncont","pgnx","pgny","pgnh","pgwsxn","pghsxn","marglsxn","margrsxn","margtsxn","margbsxn","guttersxn","f","fs","fnil","froman","fswiss","fmodern","fscript","fdecor","ftech","fbidi","fcharset","cf","cb","cpg","expnd","expndtw","kerning","b","i","ul","ulnone","ulw","uld","uldb","ulth","ulthd","ulthdash","ulthdashd","ulthdashdd","strike","sub","super","nosupersub","scaps","outl","shad","v","fsxx","dn","highlight","uldash","uldashd","uldashdd","ulwave","ulhwave","ululdbwave","plain","embo","caps","nospace","lang","langfe","langnp","langfenp","noproof","stshdbch","stshfloch","stshfhich","stshfbi","par","pard","li","fi","ri","rin","line","ql","qr","qj","qc","sb","sa","sbk","pagebb","sl","slmult","pararsid","linex","brdrb","brdrs","brdrl","brdrt","brsp","tx","ltrpar","rtlpar","ab","absh","dcs","faauto","fahang","favar","fj","adjustright","keep","keepn","level","nosnap","nowwrap","shading","sect","sbknone","sbkcol","sbkpage","pgnstart","pgnrestart","pgncont","pgnx","pgny","pgnh","pgwsxn","pghsxn","marglsxn","margrsxn","margtsxn","margbsxn","guttersxn","ltrsect","rtlsect","sectunlocked","sectd","linemod","linex","line","linecont","linestart","linerestart","linestarts","linerestarts","linetts","linettm","lineppage","linebpage","trowd","cell","row","intbl","irow","irowband","trql","trqr","trqc","trrh","trleft","cellx","clmgf","clmrg","clvmgf","clvmrg","clvertalt","clvertalc","clvertalb","cltxlrtb","cltxbtlr","cltxtbrl","cltxlrtbv","cltxtbrlv","trbrdrb","trbrdrl","trbrdrr","trbrdrt","clbrdrb","clbrdrl","clbrdrr","clbrdrt","brdrtbl","brdrnil","clpadl","clpadt","clpadr","clpadb","cellpaddl","cellpaddt","cellpaddr","cellpadb","clshdng","clcfpat","clcbpat","ls","li","fi","pn","pnlvl","ilvl","listtext","list","listtable","listname","listid","listoverride","listoverridetable","pnstart","pnindent","pndec","pnlcltr","pnlcrm","pnf","pni","pnstrike","pncf","pnseclvl","pnrauth","pnrdate","pnrnot","pnrrgb","pnrpnbrk","colortbl","red","green","blue","tab","lquote","rquote","ldblquote","rdblquote","emdash","endash","bullet","~","lbr","rbr","zwbo","zwj","zwnbo","zwnj","object","pict","shp","shptxt","shprslt","shpz","sp","sn","sv","objemb","objlink","objautlink","objsub","objpub","objicemb","objhtml","objocx","u","uc","ucl","ud","info","author","creatim","revtim","version","vern","edmins","nofpages","nofwords","nofchars","nofcharsws","id","operator","category","manager","company","doccomm","hlinkbase","title","subject","keywords","comment","vern","docnofastaves","*","\\","{","}","nonesttables","nesttableprops","nestrow","nestcell","row","cell","intbl","nest","nonesttables","shpinst","shpgrp","shpwr","shpfhdr","xe","tc","txe","bkmkstart","bkmkend","field","fldinst","fldrslt","datafield","formfield","formfield","ffname","ffdeftext","ffformat","ffhelptext","ffstattext"] ;
const text = "\\par{\\qc\\b\\fs28 La libertad del creyente\\par} \\'abTodo est\\'e1 permitido\\'bb, pero no todo es provechoso. \\'abTodo est\\'e1 permitido\\'bb, pero no todo es constructivo.";

const cleanedText = removeRtfKeywords(text, rtfKeywords);

console.log(`Original: ${text}`);
console.log(`Modified: ${cleanedText}`);
