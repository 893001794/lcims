

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script   type="text/javascript"   src="../../javascript/treeform/xtree.js"></script>
        <script   type="text/javascript"   src="../../javascript/treeform/xmlextras.js"></script>
        <script   type="text/javascript"   src="../../javascript/treeform/xloadtree.js"></script>
        <link   type="text/css" rel="stylesheet"  href="../../css/xtree.css"   />
        <title>JSP Page</title>
    </head>
    <body>
        <script type="text/javascript">
            /// XP Look
            webFXTreeConfig.rootIcon        = "../../images/xp/folder.png";
            webFXTreeConfig.openRootIcon    = "../../images/xp/openfolder.png";
            webFXTreeConfig.folderIcon        = "../../images/xp/folder.png";
            webFXTreeConfig.openFolderIcon    = "../../images/xp/openfolder.png";
            webFXTreeConfig.fileIcon        = "../../images/xp/file.png";
            webFXTreeConfig.lMinusIcon        = "../../images/xp/Lminus.png";
            webFXTreeConfig.lPlusIcon        = "../../images/xp/Lplus.png";
            webFXTreeConfig.tMinusIcon        = "../../images/xp/Tminus.png";
            webFXTreeConfig.tPlusIcon        = "../../images/xp/Tplus.png";
            webFXTreeConfig.iIcon            = "../../images/xp/I.png";
            webFXTreeConfig.lIcon            = "../../images/xp/L.png";
            webFXTreeConfig.tIcon            = "../../images/xp/T.png";
            var rti;
            var tree = new WebFXTree("项目");
            tree.add(new WebFXLoadTreeItem("电子电器项目", "../../phpXloadTree"));
            document.write(tree);
        </script>
    </body>
</html>
