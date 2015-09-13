package com.org.edi.util.tools;

public class EdiMetaInfo {
	private String category = "";
	private String isStart = "";
	private String lseName = "";
	private String lseDesc = "";
	private int minOccurence;
	private int maxOccurence;
	private int minLength;
	private int maxLength;
	private String dataType = "";
	private int precission;
	private String pattern = "";
	private String validVals = "";
	private String cond = "";
	private String condVals = "";

	public EdiMetaInfo(String category, String isStart, String lseName, String lseDesc, int minOccurence,
			int maxOccurence, int minLength, int maxLength, String dataType, int precission, String pattern,
			String validVals, String cond, String condVals) {
		super();
		this.category = category.trim();
		this.isStart = isStart.trim();
		this.lseName = lseName.trim();
		this.lseDesc = lseDesc.trim();
		this.minOccurence = minOccurence;
		this.maxOccurence = maxOccurence;
		this.minLength = minLength;
		this.maxLength = maxLength;
		this.dataType = dataType.trim();
		this.precission = precission;
		this.pattern = pattern.trim();
		this.validVals = validVals.trim();
		this.cond = cond.trim();
		this.setCondVals(condVals.trim());
	}

	public EdiMetaInfo(String str) {
		if (!str.trim().isEmpty()) {
			String[] strArr = str.split("\t", 14);

			this.category = strArr[0].trim();
			this.isStart = strArr[1].trim();
			this.lseName = strArr[2].trim();
			this.lseDesc = strArr[3].trim();

			if (strArr[4].trim().equalsIgnoreCase("Required"))
				this.minOccurence = 1;
			if (strArr[4].trim().equalsIgnoreCase("Optional"))
				this.minOccurence = 0;
			else if (strArr[5].trim().isEmpty())
				this.minOccurence = 0;

			if (!strArr[5].trim().isEmpty() && !strArr[5].trim().equalsIgnoreCase("unbounded"))
				this.maxOccurence = Integer.parseInt(strArr[5].trim());
			else if (!strArr[5].trim().isEmpty() && strArr[5].trim().equalsIgnoreCase("unbounded"))
				this.maxOccurence = 9999;
			else if (strArr[5].trim().isEmpty())
				this.maxOccurence = 1;

			if (!strArr[6].trim().isEmpty())
				this.minLength = Integer.parseInt(strArr[6].trim());

			if (!strArr[7].trim().isEmpty())
				this.maxLength = Integer.parseInt(strArr[7].trim());

			this.dataType = strArr[8].trim();

			if (!strArr[9].trim().isEmpty())
				this.precission = Integer.parseInt(strArr[9].trim());

			if (!strArr[10].trim().isEmpty())
				this.pattern = strArr[10].trim();
			else
				this.pattern = "";
			if (!strArr[11].trim().isEmpty())
				this.validVals = strArr[11].trim();
			else
				this.validVals = "";

			if (!strArr[12].trim().isEmpty())
				this.cond = strArr[12].trim();
			else
				this.cond = "";

			if (!strArr[13].trim().isEmpty())
				this.setCondVals(strArr[13].trim());
			else
				this.setCondVals("");
		}
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getIsStart() {
		return isStart;
	}

	public void setIsStart(String isStart) {
		this.isStart = isStart;
	}

	public String getLseName() {
		return lseName;
	}

	public void setLseName(String lseName) {
		this.lseName = lseName;
	}

	public String getLseDesc() {
		return lseDesc;
	}

	public void setLseDesc(String lseDesc) {
		this.lseDesc = lseDesc;
	}

	public int getMinOccurence() {
		return minOccurence;
	}

	public void setMinOccurence(int minOccurence) {
		this.minOccurence = minOccurence;
	}

	public int getMaxOccurence() {
		return maxOccurence;
	}

	public void setMaxOccurence(int maxOccurence) {
		this.maxOccurence = maxOccurence;
	}

	public int getMinLength() {
		return minLength;
	}

	public void setMinLength(int minLength) {
		this.minLength = minLength;
	}

	public int getMaxLength() {
		return maxLength;
	}

	public void setMaxLength(int maxLength) {
		this.maxLength = maxLength;
	}

	public String getDataType() {
		return dataType;
	}

	public void setDataType(String dataType) {
		this.dataType = dataType;
	}

	public int getPrecission() {
		return precission;
	}

	public void setPrecission(int precission) {
		this.precission = precission;
	}

	public String getPattern() {
		return pattern;
	}

	public void setPattern(String pattern) {
		this.pattern = pattern;
	}

	public String getValidVals() {
		return validVals;
	}

	public void setValidVals(String validVals) {
		this.validVals = validVals;
	}

	public String getCond() {
		return cond;
	}

	public void setCond(String cond) {
		this.cond = cond;
	}

	public String getCondVals() {
		return condVals;
	}

	public void setCondVals(String condVals) {
		this.condVals = condVals;
	}

	@Override
	public String toString() {
		return "EdiMetaInfo [category=" + category + ", isStart=" + isStart + ", lseName=" + lseName + ", lseDesc="
				+ lseDesc + ", minOccurence=" + minOccurence + ", maxOccurence=" + maxOccurence + ", minLength="
				+ minLength + ", maxLength=" + maxLength + ", dataType=" + dataType + ", precission=" + precission
				+ ", pattern=" + pattern + ", validVals=" + validVals + ", cond=" + cond + ", condVals=" + condVals
				+ "]";
	}

	public String getSchemaDataType() {
		String result = "";
		switch (dataType) {
		case "ID":
			result = "xs:string";
			break;
		case "AN":
			result = "xs:string";
			break;
		case "DT":
			result = "xs:date";
			break;
		case "TM":
			result = "xs:time";
			break;
		case "B":
			result = "xs:byte";
			break;
		case "R":
			result = "xs:decimal";
			break;
		case "N":
			if (precission > 0)
				result = "xs:decimal";
			else
				result = "xs:long";
			break;
		}
		return result;
	}

	public boolean isNull() {
		return lseName.isEmpty();
	}

	public String getElementName() {
		String result;
		if (category.trim().equalsIgnoreCase("loop")) {
			result = lseName;
			if (!isEdiRoot())
				result = lseName.substring(0, 5);
		} else
			result = lseName;
		return result.trim();
	}

	public boolean isEdiRoot() {
		return lseName.trim().equalsIgnoreCase("ediroot");
	}

	public String getConditionElement() {
		String[] condElements = cond.split("/");
		return condElements[condElements.length - 1].trim();
	}

	public String getConditions() {
		StringBuilder sb = new StringBuilder();
		if (!condVals.isEmpty()) {
			String[] validVals = condVals.split(",");
			for (int i = 0; i < validVals.length; i++) {
				if (i == 0)
					sb.append("(").append(cond).append("='").append(validVals[i].trim()).append("'");
				else
					sb.append(" or ").append(cond).append("='").append(validVals[i].trim()).append("'");
				if (i==validVals.length-1)
					sb.append(")");
			}
		}
		
		return sb.toString();
	}
	
	public String getLoopConditions() {
		StringBuilder sb = new StringBuilder();
		if (!condVals.isEmpty()) {
			String[] validVals = condVals.split(",");
			for (int i = 0; i < validVals.length; i++) {
				if (i == 0)
					sb.append("(../").append(cond).append("='").append(validVals[i].trim()).append("'");
				else
					sb.append(" or ../").append(cond).append("='").append(validVals[i].trim()).append("'");
				if (i==validVals.length-1)
					sb.append(")");
			}
		}
		
		return sb.toString();
	}
	

}
