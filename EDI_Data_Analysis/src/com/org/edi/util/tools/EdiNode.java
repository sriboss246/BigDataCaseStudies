package com.org.edi.util.tools;

public class EdiNode {
	private String absPath;
	private String condition;
	private String nodeInfo;
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public String getNodeInfo() {
		return nodeInfo;
	}
	public void setNodeInfo(String nodeInfo) {
		this.nodeInfo = nodeInfo;
	}
	public String getAbsPath() {
		return absPath;
	}
	public void setAbsPath(String absPath) {
		this.absPath = absPath;
	}
	public EdiNode(String absPath, String condition, String nodeInfo) {
		super();
		this.absPath = absPath;
		this.condition = condition;
		this.nodeInfo = nodeInfo;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		EdiNode other = (EdiNode) obj;
		if (absPath == null) {
			if (other.absPath != null)
				return false;
		} else if (!absPath.equals(other.absPath))
			return false;
		if (condition == null) {
			if (other.condition != null)
				return false;
		} else if (!condition.equals(other.condition))
			return false;
		if (nodeInfo == null) {
			if (other.nodeInfo != null)
				return false;
		} else if (!nodeInfo.equals(other.nodeInfo))
			return false;
		return true;
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder(); 
		sb.append("<xsl:when test=\"");
		sb.append("$xPath='").append(absPath).append("'");
		if (!condition.trim().isEmpty())
			sb.append(" and (").append(condition).append(")") ;
		sb.append("\">");
		sb.append(nodeInfo);
		sb.append("</xsl:when>");
		return sb.toString();
	}
}
