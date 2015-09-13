<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template name="getXPath">
		<xsl:for-each select="parent::*">
			<xsl:call-template name="getXPath" />
		</xsl:for-each>
		<xsl:value-of select="concat('/',name())" />
	</xsl:template>
	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="SV5">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2400/SV5'">
				<Durable_Medical_Equipment_Service>
					<xsl:if test="SV501">
						<Composite_Medical_Procedure_Identifier>
							<xsl:if test="SV501/SV5011">
								<Product_Service_ID_Qualifier>
									<xsl:value-of select="SV501/SV5011" />
								</Product_Service_ID_Qualifier>
							</xsl:if>
							<xsl:if test="SV501/SV5012">
								<Product_Service_ID>
									<xsl:value-of select="SV501/SV5012" />
								</Product_Service_ID>
							</xsl:if>
						</Composite_Medical_Procedure_Identifier>
					</xsl:if>
					<xsl:if test="SV502">
						<Unit_Basis_for_Measurement_Code>
							<xsl:value-of select="SV502" />
						</Unit_Basis_for_Measurement_Code>
					</xsl:if>
					<xsl:if test="SV503">
						<Quantity>
							<xsl:value-of select="SV503" />
						</Quantity>
					</xsl:if>
					<xsl:if test="SV504">
						<Monetary_Amount>
							<xsl:value-of select="SV504" />
						</Monetary_Amount>
					</xsl:if>
					<xsl:if test="SV505">
						<Monetary_Amount_2>
							<xsl:value-of select="SV505" />
						</Monetary_Amount_2>
					</xsl:if>
					<xsl:if test="SV506">
						<Frequency_Code>
							<xsl:value-of select="SV506" />
						</Frequency_Code>
					</xsl:if>
				</Durable_Medical_Equipment_Service>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="TA1">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/TA1'">
				<Interchange_Acknowledgement>
					<xsl:if test="TA101">
						<Interchange_Control_Number>
							<xsl:value-of select="TA101" />
						</Interchange_Control_Number>
					</xsl:if>
					<xsl:if test="TA102">
						<Interchange_Date>
							<xsl:value-of select="TA102" />
						</Interchange_Date>
					</xsl:if>
					<xsl:if test="TA103">
						<Interchange_Time>
							<xsl:value-of select="TA103" />
						</Interchange_Time>
					</xsl:if>
					<xsl:if test="TA104">
						<Interchange_Acknowledgement_Code>
							<xsl:value-of select="TA104" />
						</Interchange_Acknowledgement_Code>
					</xsl:if>
					<xsl:if test="TA105">
						<Interchange_Note_Code>
							<xsl:value-of select="TA105" />
						</Interchange_Note_Code>
					</xsl:if>
				</Interchange_Acknowledgement>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="NTE">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/NTE'">
				<Claim_Note>
					<xsl:if test="NTE01">
						<Note_Reference_Code>
							<xsl:value-of select="NTE01" />
						</Note_Reference_Code>
					</xsl:if>
					<xsl:if test="NTE02">
						<Desciption>
							<xsl:value-of select="NTE02" />
						</Desciption>
					</xsl:if>
				</Claim_Note>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2400/NTE'">
				<Line_Note>
					<xsl:if test="NTE01">
						<Note_Reference_Code>
							<xsl:value-of select="NTE01" />
						</Note_Reference_Code>
					</xsl:if>
					<xsl:if test="NTE02">
						<Description>
							<xsl:value-of select="NTE02" />
						</Description>
					</xsl:if>
				</Line_Note>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="GE">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/GE'">
				<Functional_Group_Trailer>
					<xsl:if test="GE01">
						<Number_of_Transaction_Sets_Included>
							<xsl:value-of select="GE01" />
						</Number_of_Transaction_Sets_Included>
					</xsl:if>
					<xsl:if test="GE02">
						<Group_Control_Number>
							<xsl:value-of select="GE02" />
						</Group_Control_Number>
					</xsl:if>
				</Functional_Group_Trailer>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="PRV">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/PRV'">
				<Billing_Pay-to_Provider_Specialty_Information>
					<xsl:if test="PRV01">
						<Provider_Code>
							<xsl:value-of select="PRV01" />
						</Provider_Code>
					</xsl:if>
					<xsl:if test="PRV02">
						<Reference_Identification_Qualifier>
							<xsl:value-of select="PRV02" />
						</Reference_Identification_Qualifier>
					</xsl:if>
					<xsl:if test="PRV03">
						<Reference_Identification>
							<xsl:value-of select="PRV03" />
						</Reference_Identification>
					</xsl:if>
				</Billing_Pay-to_Provider_Specialty_Information>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2310/PRV'">
				<Rendering_Provider_Specialty_Information>
					<xsl:if test="PRV01">
						<Provider_Code>
							<xsl:value-of select="PRV01" />
						</Provider_Code>
					</xsl:if>
					<xsl:if test="PRV02">
						<Reference_Identification_Qualifier>
							<xsl:value-of select="PRV02" />
						</Reference_Identification_Qualifier>
					</xsl:if>
					<xsl:if test="PRV03">
						<Reference_Identification>
							<xsl:value-of select="PRV03" />
						</Reference_Identification>
					</xsl:if>
				</Rendering_Provider_Specialty_Information>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="HI">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/HI'">
				<Health_Care_Diagnosis_Code>
					<xsl:if test="HI01">
						<Health_Care_Code_Information>
							<xsl:if test="HI01/HI011">
								<Code_List_Qualifier_Code>
									<xsl:value-of select="HI01/HI011" />
								</Code_List_Qualifier_Code>
							</xsl:if>
							<xsl:if test="HI01/HI012">
								<Industry_Code>
									<xsl:value-of select="HI01/HI012" />
								</Industry_Code>
							</xsl:if>
						</Health_Care_Code_Information>
					</xsl:if>
					<xsl:if test="HI02">
						<Health_Care_Code_Information_2>
							<xsl:if test="HI02/HI021">
								<Code_List_Qualifier_Code>
									<xsl:value-of select="HI02/HI021" />
								</Code_List_Qualifier_Code>
							</xsl:if>
							<xsl:if test="HI02/HI022">
								<Industry_Code>
									<xsl:value-of select="HI02/HI022" />
								</Industry_Code>
							</xsl:if>
						</Health_Care_Code_Information_2>
					</xsl:if>
					<xsl:if test="HI03">
						<Health_Care_Code_Information_3>
							<xsl:if test="HI03/HI031">
								<Code_List_Qualifier_Code>
									<xsl:value-of select="HI03/HI031" />
								</Code_List_Qualifier_Code>
							</xsl:if>
							<xsl:if test="HI03/HI032">
								<Industry_Code>
									<xsl:value-of select="HI03/HI032" />
								</Industry_Code>
							</xsl:if>
						</Health_Care_Code_Information_3>
					</xsl:if>
					<xsl:if test="HI04">
						<Health_Care_Code_Information_4>
							<xsl:if test="HI04/HI041">
								<Code_List_Qualifier_Code>
									<xsl:value-of select="HI04/HI041" />
								</Code_List_Qualifier_Code>
							</xsl:if>
							<xsl:if test="HI04/HI042">
								<Industry_Code>
									<xsl:value-of select="HI04/HI042" />
								</Industry_Code>
							</xsl:if>
						</Health_Care_Code_Information_4>
					</xsl:if>
					<xsl:if test="HI05">
						<Health_Care_Code_Information_5>
							<xsl:if test="HI05/HI051">
								<Code_List_Qualifier_Code>
									<xsl:value-of select="HI05/HI051" />
								</Code_List_Qualifier_Code>
							</xsl:if>
							<xsl:if test="HI05/HI052">
								<Industry_Code>
									<xsl:value-of select="HI05/HI052" />
								</Industry_Code>
							</xsl:if>
						</Health_Care_Code_Information_5>
					</xsl:if>
					<xsl:if test="HI06">
						<Health_Care_Code_Information_6>
							<xsl:if test="HI06/HI061">
								<Code_List_Qualifier_Code>
									<xsl:value-of select="HI06/HI061" />
								</Code_List_Qualifier_Code>
							</xsl:if>
							<xsl:if test="HI06/HI062">
								<Industry_Code>
									<xsl:value-of select="HI06/HI062" />
								</Industry_Code>
							</xsl:if>
						</Health_Care_Code_Information_6>
					</xsl:if>
					<xsl:if test="HI07">
						<Health_Care_Code_Information_7>
							<xsl:if test="HI07/HI071">
								<Code_List_Qualifier_Code>
									<xsl:value-of select="HI07/HI071" />
								</Code_List_Qualifier_Code>
							</xsl:if>
							<xsl:if test="HI07/HI072">
								<Industry_Code>
									<xsl:value-of select="HI07/HI072" />
								</Industry_Code>
							</xsl:if>
						</Health_Care_Code_Information_7>
					</xsl:if>
					<xsl:if test="HI08">
						<Health_Care_Code_Information_8>
							<xsl:if test="HI08/HI081">
								<Code_List_Qualifier_Code>
									<xsl:value-of select="HI08/HI081" />
								</Code_List_Qualifier_Code>
							</xsl:if>
							<xsl:if test="HI08/HI082">
								<Industry_Code>
									<xsl:value-of select="HI08/HI082" />
								</Industry_Code>
							</xsl:if>
						</Health_Care_Code_Information_8>
					</xsl:if>
				</Health_Care_Diagnosis_Code>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="HL">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/HL' and (HL03='20')">
				<Billing_Pay-to_Provider_Hierarchical_Level>
					<xsl:if test="HL01">
						<Hierarchical_ID_Number>
							<xsl:value-of select="HL01" />
						</Hierarchical_ID_Number>
					</xsl:if>
					<xsl:if test="HL03">
						<Hierarchical_Level_Code>
							<xsl:value-of select="HL03" />
						</Hierarchical_Level_Code>
					</xsl:if>
					<xsl:if test="HL04">
						<Hierarchical_Child_Code>
							<xsl:value-of select="HL04" />
						</Hierarchical_Child_Code>
					</xsl:if>
				</Billing_Pay-to_Provider_Hierarchical_Level>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/HL' and (HL03='22')">
				<Subscriber_Hierarchical_Level>
					<xsl:if test="HL01">
						<Hierarchical_ID_Number>
							<xsl:value-of select="HL01" />
						</Hierarchical_ID_Number>
					</xsl:if>
					<xsl:if test="HL02">
						<Hierarchical_Parent_ID_Number>
							<xsl:value-of select="HL02" />
						</Hierarchical_Parent_ID_Number>
					</xsl:if>
					<xsl:if test="HL03">
						<Hierarchical_Level_Code>
							<xsl:value-of select="HL03" />
						</Hierarchical_Level_Code>
					</xsl:if>
					<xsl:if test="HL04">
						<Hierarchical_Child_Code>
							<xsl:value-of select="HL04" />
						</Hierarchical_Child_Code>
					</xsl:if>
				</Subscriber_Hierarchical_Level>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/HL' and (HL03='23')">
				<Patient_Hierarchical_Level>
					<xsl:if test="HL01">
						<Hierarchical_ID_Number>
							<xsl:value-of select="HL01" />
						</Hierarchical_ID_Number>
					</xsl:if>
					<xsl:if test="HL02">
						<Hierarchical_Parent_ID_Number>
							<xsl:value-of select="HL02" />
						</Hierarchical_Parent_ID_Number>
					</xsl:if>
					<xsl:if test="HL03">
						<Hierarchical_Level_Code>
							<xsl:value-of select="HL03" />
						</Hierarchical_Level_Code>
					</xsl:if>
					<xsl:if test="HL04">
						<Hierarchical_Child_Code>
							<xsl:value-of select="HL04" />
						</Hierarchical_Child_Code>
					</xsl:if>
				</Patient_Hierarchical_Level>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="AMT">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/AMT'">
				<Patient_Amount_Paid>
					<xsl:if test="AMT01">
						<Amount_Qualifier_Code>
							<xsl:value-of select="AMT01" />
						</Amount_Qualifier_Code>
					</xsl:if>
					<xsl:if test="AMT02">
						<Monetary_Amount>
							<xsl:value-of select="AMT02" />
						</Monetary_Amount>
					</xsl:if>
				</Patient_Amount_Paid>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2320/AMT' and (AMT01='D')">
				<COB_Payer_Paid_Amount>
					<xsl:if test="AMT01">
						<Amount_Qualifier_Code>
							<xsl:value-of select="AMT01" />
						</Amount_Qualifier_Code>
					</xsl:if>
					<xsl:if test="AMT02">
						<Monetary_Amount>
							<xsl:value-of select="AMT02" />
						</Monetary_Amount>
					</xsl:if>
				</COB_Payer_Paid_Amount>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2320/AMT' and (AMT01='B6')">
				<COB_Allowed_Amount>
					<xsl:if test="AMT01">
						<Amount_Qualifier_Code>
							<xsl:value-of select="AMT01" />
						</Amount_Qualifier_Code>
					</xsl:if>
					<xsl:if test="AMT02">
						<Monetary_Amount>
							<xsl:value-of select="AMT02" />
						</Monetary_Amount>
					</xsl:if>
				</COB_Allowed_Amount>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2320/AMT' and (AMT01='F2')">
				<COB_Patient_Responsibility_Amount>
					<xsl:if test="AMT01">
						<Amount_Qualifier_Code>
							<xsl:value-of select="AMT01" />
						</Amount_Qualifier_Code>
					</xsl:if>
					<xsl:if test="AMT02">
						<Monetary_Amount>
							<xsl:value-of select="AMT02" />
						</Monetary_Amount>
					</xsl:if>
				</COB_Patient_Responsibility_Amount>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2320/AMT' and (AMT01='F5')">
				<COB_Patient_Paid_Amount>
					<xsl:if test="AMT01">
						<Amount_Qualifier_Code>
							<xsl:value-of select="AMT01" />
						</Amount_Qualifier_Code>
					</xsl:if>
					<xsl:if test="AMT02">
						<Monetary_Amount>
							<xsl:value-of select="AMT02" />
						</Monetary_Amount>
					</xsl:if>
				</COB_Patient_Paid_Amount>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="LX">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2400/LX'">
				<Service_Line>
					<xsl:if test="LX01">
						<Assigned_Number>
							<xsl:value-of select="LX01" />
						</Assigned_Number>
					</xsl:if>
				</Service_Line>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="PER">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L1000/PER'">
				<Submitter_EDI_Contact_Information>
					<xsl:if test="PER01">
						<Contact_Function_Code>
							<xsl:value-of select="PER01" />
						</Contact_Function_Code>
					</xsl:if>
					<xsl:if test="PER02">
						<Name>
							<xsl:value-of select="PER02" />
						</Name>
					</xsl:if>
					<xsl:if test="PER03">
						<Communication_Number_Qualifier>
							<xsl:value-of select="PER03" />
						</Communication_Number_Qualifier>
					</xsl:if>
					<xsl:if test="PER04">
						<Communication_Number>
							<xsl:value-of select="PER04" />
						</Communication_Number>
					</xsl:if>
					<xsl:if test="PER05">
						<Communication_Number_Qualifier_2>
							<xsl:value-of select="PER05" />
						</Communication_Number_Qualifier_2>
					</xsl:if>
					<xsl:if test="PER06">
						<Communication_Number_2>
							<xsl:value-of select="PER06" />
						</Communication_Number_2>
					</xsl:if>
					<xsl:if test="PER07">
						<Communication_Number_Qualifier_3>
							<xsl:value-of select="PER07" />
						</Communication_Number_Qualifier_3>
					</xsl:if>
					<xsl:if test="PER08">
						<Communication_Number_3>
							<xsl:value-of select="PER08" />
						</Communication_Number_3>
					</xsl:if>
				</Submitter_EDI_Contact_Information>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2320/L2330/PER'">
				<Other_Payer_Contact_Information>
					<xsl:if test="PER01">
						<Contact_Function_Code>
							<xsl:value-of select="PER01" />
						</Contact_Function_Code>
					</xsl:if>
					<xsl:if test="PER02">
						<Name>
							<xsl:value-of select="PER02" />
						</Name>
					</xsl:if>
					<xsl:if test="PER03">
						<Communication_Number_Qualifier>
							<xsl:value-of select="PER03" />
						</Communication_Number_Qualifier>
					</xsl:if>
					<xsl:if test="PER04">
						<Communication_Number>
							<xsl:value-of select="PER04" />
						</Communication_Number>
					</xsl:if>
					<xsl:if test="PER05">
						<Communication_Number_Qualifier_2>
							<xsl:value-of select="PER05" />
						</Communication_Number_Qualifier_2>
					</xsl:if>
					<xsl:if test="PER06">
						<Communication_Number_2>
							<xsl:value-of select="PER06" />
						</Communication_Number_2>
					</xsl:if>
					<xsl:if test="PER07">
						<Communication_Number_Qualifier_3>
							<xsl:value-of select="PER07" />
						</Communication_Number_Qualifier_3>
					</xsl:if>
					<xsl:if test="PER08">
						<Communication_Number_3>
							<xsl:value-of select="PER08" />
						</Communication_Number_3>
					</xsl:if>
				</Other_Payer_Contact_Information>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="L2000">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000' and (HL/HL03='20')">
				<L2000A>
					<xsl:apply-templates select="node()|@*" />
				</L2000A>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000' and (HL/HL03='22')">
				<L2000B>
					<xsl:apply-templates select="node()|@*" />
				</L2000B>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000' and (HL/HL03='23')">
				<L2000C>
					<xsl:apply-templates select="node()|@*" />
				</L2000C>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="CLM">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/CLM'">
				<Claim_Information>
					<xsl:if test="CLM01">
						<Claim_Submitters_Identifier>
							<xsl:value-of select="CLM01" />
						</Claim_Submitters_Identifier>
					</xsl:if>
					<xsl:if test="CLM02">
						<Monetary_Amount>
							<xsl:value-of select="CLM02" />
						</Monetary_Amount>
					</xsl:if>
					<xsl:if test="CLM05">
						<Health_Care_Service_Location_Information>
							<xsl:if test="CLM05/CLM051">
								<Facility_Code_Value>
									<xsl:value-of select="CLM05/CLM051" />
								</Facility_Code_Value>
							</xsl:if>
							<xsl:if test="CLM05/CLM052">
								<Claim_Frequency_Type_Code>
									<xsl:value-of select="CLM05/CLM052" />
								</Claim_Frequency_Type_Code>
							</xsl:if>
						</Health_Care_Service_Location_Information>
					</xsl:if>
					<xsl:if test="CLM06">
						<Condition_Response_Code>
							<xsl:value-of select="CLM06" />
						</Condition_Response_Code>
					</xsl:if>
					<xsl:if test="CLM07">
						<Provider_Accept_Assignment_Code>
							<xsl:value-of select="CLM07" />
						</Provider_Accept_Assignment_Code>
					</xsl:if>
					<xsl:if test="CLM08">
						<Condition_Response_Code_2>
							<xsl:value-of select="CLM08" />
						</Condition_Response_Code_2>
					</xsl:if>
					<xsl:if test="CLM09">
						<Release_of_Information_Code>
							<xsl:value-of select="CLM09" />
						</Release_of_Information_Code>
					</xsl:if>
					<xsl:if test="CLM10">
						<Patient_Signature_Source_Code>
							<xsl:value-of select="CLM10" />
						</Patient_Signature_Source_Code>
					</xsl:if>
					<xsl:if test="CLM11">
						<Related_Causes_Information>
							<xsl:if test="CLM11/CLM111">
								<Related-Causes_Code>
									<xsl:value-of select="CLM11/CLM111" />
								</Related-Causes_Code>
							</xsl:if>
							<xsl:if test="CLM11/CLM112">
								<Related-Causes_Code_2>
									<xsl:value-of select="CLM11/CLM112" />
								</Related-Causes_Code_2>
							</xsl:if>
							<xsl:if test="CLM11/CLM113">
								<Related-Causes_Code_3>
									<xsl:value-of select="CLM11/CLM113" />
								</Related-Causes_Code_3>
							</xsl:if>
							<xsl:if test="CLM11/CLM114">
								<State_Province_Code>
									<xsl:value-of select="CLM11/CLM114" />
								</State_Province_Code>
							</xsl:if>
							<xsl:if test="CLM11/CLM115">
								<Country_Code>
									<xsl:value-of select="CLM11/CLM115" />
								</Country_Code>
							</xsl:if>
						</Related_Causes_Information>
					</xsl:if>
					<xsl:if test="CLM12">
						<Special_Program_Code>
							<xsl:value-of select="CLM12" />
						</Special_Program_Code>
					</xsl:if>
					<xsl:if test="CLM16">
						<Provider_Agreement_Code>
							<xsl:value-of select="CLM16" />
						</Provider_Agreement_Code>
					</xsl:if>
					<xsl:if test="CLM20">
						<Delay_Reason_Code>
							<xsl:value-of select="CLM20" />
						</Delay_Reason_Code>
					</xsl:if>
				</Claim_Information>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="BHT">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/BHT'">
				<Beginning_of_Hierarchical_Transaction>
					<xsl:if test="BHT01">
						<Hierarchical_Structure_Code>
							<xsl:value-of select="BHT01" />
						</Hierarchical_Structure_Code>
					</xsl:if>
					<xsl:if test="BHT02">
						<Transaction_Set_Purpose_Code>
							<xsl:value-of select="BHT02" />
						</Transaction_Set_Purpose_Code>
					</xsl:if>
					<xsl:if test="BHT03">
						<Reference_Identification>
							<xsl:value-of select="BHT03" />
						</Reference_Identification>
					</xsl:if>
					<xsl:if test="BHT04">
						<Date>
							<xsl:value-of select="BHT04" />
						</Date>
					</xsl:if>
					<xsl:if test="BHT05">
						<Time>
							<xsl:value-of select="BHT05" />
						</Time>
					</xsl:if>
					<xsl:if test="BHT06">
						<Transaction_Type_Code>
							<xsl:value-of select="BHT06" />
						</Transaction_Type_Code>
					</xsl:if>
				</Beginning_of_Hierarchical_Transaction>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="ST">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/ST'">
				<Transaction_Set_Header>
					<xsl:if test="ST01">
						<Transaction_Set_Identifier_Code>
							<xsl:value-of select="ST01" />
						</Transaction_Set_Identifier_Code>
					</xsl:if>
					<xsl:if test="ST02">
						<Transaction_Set_Control_Number>
							<xsl:value-of select="ST02" />
						</Transaction_Set_Control_Number>
					</xsl:if>
				</Transaction_Set_Header>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="DMG">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2010/DMG'">
				<Patient_Demographic_Information>
					<xsl:if test="DMG01">
						<Date_Time_Period_Format_Qualifier>
							<xsl:value-of select="DMG01" />
						</Date_Time_Period_Format_Qualifier>
					</xsl:if>
					<xsl:if test="DMG02">
						<Date_Time_Period>
							<xsl:value-of select="DMG02" />
						</Date_Time_Period>
					</xsl:if>
					<xsl:if test="DMG03">
						<Gender_Code>
							<xsl:value-of select="DMG03" />
						</Gender_Code>
					</xsl:if>
				</Patient_Demographic_Information>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2320/DMG'">
				<Subscriber_Demographic_Information>
					<xsl:if test="DMG01">
						<Date_Time_Period_Format_Qualifier>
							<xsl:value-of select="DMG01" />
						</Date_Time_Period_Format_Qualifier>
					</xsl:if>
					<xsl:if test="DMG02">
						<Date_Time_Period>
							<xsl:value-of select="DMG02" />
						</Date_Time_Period>
					</xsl:if>
					<xsl:if test="DMG03">
						<Gender_Code>
							<xsl:value-of select="DMG03" />
						</Gender_Code>
					</xsl:if>
				</Subscriber_Demographic_Information>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="OI">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2320/OI'">
				<Other_Insurance_Coverage_Information>
					<xsl:if test="OI03">
						<Condition_Response_Code>
							<xsl:value-of select="OI03" />
						</Condition_Response_Code>
					</xsl:if>
					<xsl:if test="OI04">
						<Patient_Signature_Source_Code>
							<xsl:value-of select="OI04" />
						</Patient_Signature_Source_Code>
					</xsl:if>
					<xsl:if test="OI06">
						<Release_of_Information_Code>
							<xsl:value-of select="OI06" />
						</Release_of_Information_Code>
					</xsl:if>
				</Other_Insurance_Coverage_Information>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="L2310">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2310' and (NM1/NM101='DN' or NM1/NM101='P3')">
				<L2310A>
					<xsl:apply-templates select="node()|@*" />
				</L2310A>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2310' and (NM1/NM101='82')">
				<L2310B>
					<xsl:apply-templates select="node()|@*" />
				</L2310B>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2310' and (NM1/NM101='77' or NM1/NM101='FA' or NM1/NM101='LI' or NM1/NM101='TL')">
				<L2310D>
					<xsl:apply-templates select="node()|@*" />
				</L2310D>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="L2430">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2400/L2430'">
				<L2430>
					<xsl:apply-templates select="node()|@*" />
				</L2430>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="CAS">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2320/CAS'">
				<Claim_Level_Adjustments>
					<xsl:if test="CAS01">
						<Claim_Adjustment_Group_Code>
							<xsl:value-of select="CAS01" />
						</Claim_Adjustment_Group_Code>
					</xsl:if>
					<xsl:if test="CAS02">
						<Claim_Adjustment_Reason_Code>
							<xsl:value-of select="CAS02" />
						</Claim_Adjustment_Reason_Code>
					</xsl:if>
					<xsl:if test="CAS03">
						<Monetary_Amount>
							<xsl:value-of select="CAS03" />
						</Monetary_Amount>
					</xsl:if>
					<xsl:if test="CAS04">
						<Quantity>
							<xsl:value-of select="CAS04" />
						</Quantity>
					</xsl:if>
					<xsl:if test="CAS05">
						<Claim_Adjustment_Reason_Code_2>
							<xsl:value-of select="CAS05" />
						</Claim_Adjustment_Reason_Code_2>
					</xsl:if>
					<xsl:if test="CAS06">
						<Monetary_Amount_2>
							<xsl:value-of select="CAS06" />
						</Monetary_Amount_2>
					</xsl:if>
					<xsl:if test="CAS07">
						<Quantity_2>
							<xsl:value-of select="CAS07" />
						</Quantity_2>
					</xsl:if>
					<xsl:if test="CAS08">
						<Claim_Adjustment_Reason_Code_3>
							<xsl:value-of select="CAS08" />
						</Claim_Adjustment_Reason_Code_3>
					</xsl:if>
					<xsl:if test="CAS09">
						<Monetary_Amount_3>
							<xsl:value-of select="CAS09" />
						</Monetary_Amount_3>
					</xsl:if>
					<xsl:if test="CAS10">
						<Quantity_3>
							<xsl:value-of select="CAS10" />
						</Quantity_3>
					</xsl:if>
					<xsl:if test="CAS11">
						<Claim_Adjustment_Reason_Code_4>
							<xsl:value-of select="CAS11" />
						</Claim_Adjustment_Reason_Code_4>
					</xsl:if>
					<xsl:if test="CAS12">
						<Monetary_Amount_4>
							<xsl:value-of select="CAS12" />
						</Monetary_Amount_4>
					</xsl:if>
					<xsl:if test="CAS13">
						<Quantity_4>
							<xsl:value-of select="CAS13" />
						</Quantity_4>
					</xsl:if>
					<xsl:if test="CAS14">
						<Claim_Adjustment_Reason_Code_5>
							<xsl:value-of select="CAS14" />
						</Claim_Adjustment_Reason_Code_5>
					</xsl:if>
					<xsl:if test="CAS15">
						<Monetary_Amount_5>
							<xsl:value-of select="CAS15" />
						</Monetary_Amount_5>
					</xsl:if>
					<xsl:if test="CAS16">
						<Quantity_5>
							<xsl:value-of select="CAS16" />
						</Quantity_5>
					</xsl:if>
					<xsl:if test="CAS17">
						<Claim_Adjustment_Reason_Code_6>
							<xsl:value-of select="CAS17" />
						</Claim_Adjustment_Reason_Code_6>
					</xsl:if>
					<xsl:if test="CAS18">
						<Monetary_Amount_6>
							<xsl:value-of select="CAS18" />
						</Monetary_Amount_6>
					</xsl:if>
					<xsl:if test="CAS19">
						<Quantity_6>
							<xsl:value-of select="CAS19" />
						</Quantity_6>
					</xsl:if>
				</Claim_Level_Adjustments>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2400/L2430/CAS'">
				<Line_Adjustment>
					<xsl:if test="CAS01">
						<Claim_Adjustment_Group_Code>
							<xsl:value-of select="CAS01" />
						</Claim_Adjustment_Group_Code>
					</xsl:if>
					<xsl:if test="CAS02">
						<Claim_Adjustment_Reason_Code>
							<xsl:value-of select="CAS02" />
						</Claim_Adjustment_Reason_Code>
					</xsl:if>
					<xsl:if test="CAS03">
						<Monetary_Amount>
							<xsl:value-of select="CAS03" />
						</Monetary_Amount>
					</xsl:if>
					<xsl:if test="CAS04">
						<Quantity>
							<xsl:value-of select="CAS04" />
						</Quantity>
					</xsl:if>
					<xsl:if test="CAS05">
						<Claim_Adjustment_Reason_Code_2>
							<xsl:value-of select="CAS05" />
						</Claim_Adjustment_Reason_Code_2>
					</xsl:if>
					<xsl:if test="CAS06">
						<Monetary_Amount_2>
							<xsl:value-of select="CAS06" />
						</Monetary_Amount_2>
					</xsl:if>
					<xsl:if test="CAS07">
						<Quantity_2>
							<xsl:value-of select="CAS07" />
						</Quantity_2>
					</xsl:if>
					<xsl:if test="CAS08">
						<Claim_Adjustment_Reason_Code_3>
							<xsl:value-of select="CAS08" />
						</Claim_Adjustment_Reason_Code_3>
					</xsl:if>
					<xsl:if test="CAS09">
						<Monetary_Amount_3>
							<xsl:value-of select="CAS09" />
						</Monetary_Amount_3>
					</xsl:if>
					<xsl:if test="CAS10">
						<Quantity_3>
							<xsl:value-of select="CAS10" />
						</Quantity_3>
					</xsl:if>
					<xsl:if test="CAS11">
						<Claim_Adjustment_Reason_Code_4>
							<xsl:value-of select="CAS11" />
						</Claim_Adjustment_Reason_Code_4>
					</xsl:if>
					<xsl:if test="CAS12">
						<Monetary_Amount_4>
							<xsl:value-of select="CAS12" />
						</Monetary_Amount_4>
					</xsl:if>
					<xsl:if test="CAS13">
						<Quantity_4>
							<xsl:value-of select="CAS13" />
						</Quantity_4>
					</xsl:if>
					<xsl:if test="CAS14">
						<Claim_Adjustment_Reason_Code_5>
							<xsl:value-of select="CAS14" />
						</Claim_Adjustment_Reason_Code_5>
					</xsl:if>
					<xsl:if test="CAS15">
						<Monetary_Amount_5>
							<xsl:value-of select="CAS15" />
						</Monetary_Amount_5>
					</xsl:if>
					<xsl:if test="CAS16">
						<Quantity_5>
							<xsl:value-of select="CAS16" />
						</Quantity_5>
					</xsl:if>
					<xsl:if test="CAS17">
						<Claim_Adjustment_Reason_Code_6>
							<xsl:value-of select="CAS17" />
						</Claim_Adjustment_Reason_Code_6>
					</xsl:if>
					<xsl:if test="CAS18">
						<Monetary_Amount_6>
							<xsl:value-of select="CAS18" />
						</Monetary_Amount_6>
					</xsl:if>
					<xsl:if test="CAS19">
						<Quantity_6>
							<xsl:value-of select="CAS19" />
						</Quantity_6>
					</xsl:if>
				</Line_Adjustment>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="L2330">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2320/L2330' and (NM1/NM101='IL')">
				<L2330A>
					<xsl:apply-templates select="node()|@*" />
				</L2330A>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2320/L2330' and (NM1/NM101='PR')">
				<L2330B>
					<xsl:apply-templates select="node()|@*" />
				</L2330B>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2320/L2330' and (NM1/NM101='QC')">
				<L2330C>
					<xsl:apply-templates select="node()|@*" />
				</L2330C>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2320/L2330' and (NM1/NM101='DN' or NM1/NM101='P3')">
				<L2330D>
					<xsl:apply-templates select="node()|@*" />
				</L2330D>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2320/L2330' and (NM1/NM101='82')">
				<L2330E>
					<xsl:apply-templates select="node()|@*" />
				</L2330E>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2320/L2330' and (NM1/NM101='QB')">
				<L2330F>
					<xsl:apply-templates select="node()|@*" />
				</L2330F>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2320/L2330' and (NM1/NM101='77' or NM1/NM101='FA' or NM1/NM101='LI' or NM1/NM101='TL')">
				<L2330G>
					<xsl:apply-templates select="node()|@*" />
				</L2330G>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="SV1">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2400/SV1'">
				<Professional_Service>
					<xsl:if test="SV101">
						<Composite_Medical_Procedure_Identifier>
							<xsl:if test="SV101/SV1011">
								<Product_Service_ID_Qualifier>
									<xsl:value-of select="SV101/SV1011" />
								</Product_Service_ID_Qualifier>
							</xsl:if>
							<xsl:if test="SV101/SV1012">
								<Product_Service_ID>
									<xsl:value-of select="SV101/SV1012" />
								</Product_Service_ID>
							</xsl:if>
							<xsl:if test="SV101/SV1013">
								<Procedure_Modifier>
									<xsl:value-of select="SV101/SV1013" />
								</Procedure_Modifier>
							</xsl:if>
							<xsl:if test="SV101/SV1014">
								<Procedure_Modifier_2>
									<xsl:value-of select="SV101/SV1014" />
								</Procedure_Modifier_2>
							</xsl:if>
							<xsl:if test="SV101/SV1015">
								<Procedure_Modifier_3>
									<xsl:value-of select="SV101/SV1015" />
								</Procedure_Modifier_3>
							</xsl:if>
							<xsl:if test="SV101/SV1016">
								<Procedure_Modifier_4>
									<xsl:value-of select="SV101/SV1016" />
								</Procedure_Modifier_4>
							</xsl:if>
						</Composite_Medical_Procedure_Identifier>
					</xsl:if>
					<xsl:if test="SV102">
						<Monetary_Amount>
							<xsl:value-of select="SV102" />
						</Monetary_Amount>
					</xsl:if>
					<xsl:if test="SV103">
						<Unit_Basis_for_Measurement_Code>
							<xsl:value-of select="SV103" />
						</Unit_Basis_for_Measurement_Code>
					</xsl:if>
					<xsl:if test="SV104">
						<Quantity>
							<xsl:value-of select="SV104" />
						</Quantity>
					</xsl:if>
					<xsl:if test="SV105">
						<Facility_Code_Value>
							<xsl:value-of select="SV105" />
						</Facility_Code_Value>
					</xsl:if>
					<xsl:if test="SV107">
						<Composite_Diagnosis_Code_Pointer>
							<xsl:if test="SV107/SV1071">
								<Diagnosis_Code_Pointer>
									<xsl:value-of select="SV107/SV1071" />
								</Diagnosis_Code_Pointer>
							</xsl:if>
							<xsl:if test="SV107/SV1072">
								<Diagnosis_Code_Pointer_2>
									<xsl:value-of select="SV107/SV1072" />
								</Diagnosis_Code_Pointer_2>
							</xsl:if>
							<xsl:if test="SV107/SV1073">
								<Diagnosis_Code_Pointer_3>
									<xsl:value-of select="SV107/SV1073" />
								</Diagnosis_Code_Pointer_3>
							</xsl:if>
							<xsl:if test="SV107/SV1074">
								<Diagnosis_Code_Pointer_4>
									<xsl:value-of select="SV107/SV1074" />
								</Diagnosis_Code_Pointer_4>
							</xsl:if>
						</Composite_Diagnosis_Code_Pointer>
					</xsl:if>
					<xsl:if test="SV109">
						<Condition_Response_Code>
							<xsl:value-of select="SV109" />
						</Condition_Response_Code>
					</xsl:if>
					<xsl:if test="SV111">
						<Condition_Response_Code_2>
							<xsl:value-of select="SV111" />
						</Condition_Response_Code_2>
					</xsl:if>
					<xsl:if test="SV112">
						<Condition_Response_Code_3>
							<xsl:value-of select="SV112" />
						</Condition_Response_Code_3>
					</xsl:if>
					<xsl:if test="SV115">
						<Copay_Status_Code>
							<xsl:value-of select="SV115" />
						</Copay_Status_Code>
					</xsl:if>
				</Professional_Service>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="REF">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/REF'">
				<Transmission_Type_Identification>
					<xsl:if test="REF01">
						<Reference_Identification_Qualifier>
							<xsl:value-of select="REF01" />
						</Reference_Identification_Qualifier>
					</xsl:if>
					<xsl:if test="REF02">
						<Reference_Identification>
							<xsl:value-of select="REF02" />
						</Reference_Identification>
					</xsl:if>
				</Transmission_Type_Identification>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2010/REF' and (REF01='1B' or REF01='EI' or REF01='G2')">
				<Billing_Provider_Secondary_Identification>
					<xsl:if test="REF01">
						<Reference_Identification_Qualifier>
							<xsl:value-of select="REF01" />
						</Reference_Identification_Qualifier>
					</xsl:if>
					<xsl:if test="REF02">
						<Reference_Identification>
							<xsl:value-of select="REF02" />
						</Reference_Identification>
					</xsl:if>
				</Billing_Provider_Secondary_Identification>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/REF' and (REF01='EW')">
				<Mammography_Certification_Number>
					<xsl:if test="REF01">
						<Reference_Identification_Qualifier>
							<xsl:value-of select="REF01" />
						</Reference_Identification_Qualifier>
					</xsl:if>
					<xsl:if test="REF02">
						<Reference_Identification>
							<xsl:value-of select="REF02" />
						</Reference_Identification>
					</xsl:if>
				</Mammography_Certification_Number>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/REF' and (REF01='9F' or REF01='G1')">
				<Prior_Authorization_Referral_Number>
					<xsl:if test="REF01">
						<Reference_Identification_Qualifier>
							<xsl:value-of select="REF01" />
						</Reference_Identification_Qualifier>
					</xsl:if>
					<xsl:if test="REF02">
						<Reference_Identification>
							<xsl:value-of select="REF02" />
						</Reference_Identification>
					</xsl:if>
				</Prior_Authorization_Referral_Number>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2310/REF' and (REF01='1B' or REF01='EI' or REF01='G2')">
				<Service_Facility_Location_Secondary_Identification>
					<xsl:if test="REF01">
						<Reference_Identification_Qualifier>
							<xsl:value-of select="REF01" />
						</Reference_Identification_Qualifier>
					</xsl:if>
					<xsl:if test="REF02">
						<Reference_Identification>
							<xsl:value-of select="REF02" />
						</Reference_Identification>
					</xsl:if>
				</Service_Facility_Location_Secondary_Identification>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2320/L2330/REF' and (REF01='2U' or REF01='F8' or REF01='FY' or REF01='NF' or REF01='TJ')">
				<Other_Payer_Secondary_Identifier>
					<xsl:if test="REF01">
						<Reference_Identification_Qualifier>
							<xsl:value-of select="REF01" />
						</Reference_Identification_Qualifier>
					</xsl:if>
					<xsl:if test="REF02">
						<Reference_Identification>
							<xsl:value-of select="REF02" />
						</Reference_Identification>
					</xsl:if>
				</Other_Payer_Secondary_Identifier>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2320/L2330/REF' and (REF01='9F' or REF01='G1')">
				<Other_Payer_Prior_Authorization_or_Referral_Number>
					<xsl:if test="REF01">
						<Reference_Identification_Qualifier>
							<xsl:value-of select="REF01" />
						</Reference_Identification_Qualifier>
					</xsl:if>
					<xsl:if test="REF02">
						<Reference_Identification>
							<xsl:value-of select="REF02" />
						</Reference_Identification>
					</xsl:if>
				</Other_Payer_Prior_Authorization_or_Referral_Number>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2320/L2330/REF' and (REF01='T4')">
				<Other_Payer_Claim_Adjustment_Indicator>
					<xsl:if test="REF01">
						<Reference_Identification_Qualifier>
							<xsl:value-of select="REF01" />
						</Reference_Identification_Qualifier>
					</xsl:if>
					<xsl:if test="REF02">
						<Reference_Identification>
							<xsl:value-of select="REF02" />
						</Reference_Identification>
					</xsl:if>
				</Other_Payer_Claim_Adjustment_Indicator>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2320/L2330/REF' and (REF01='1W')">
				<Other_Payer_Patient_Identification>
					<xsl:if test="REF01">
						<Reference_Identification_Qualifier>
							<xsl:value-of select="REF01" />
						</Reference_Identification_Qualifier>
					</xsl:if>
					<xsl:if test="REF02">
						<Reference_Identification>
							<xsl:value-of select="REF02" />
						</Reference_Identification>
					</xsl:if>
				</Other_Payer_Patient_Identification>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2320/L2330/REF'">
				<Other_Payer_Referring_Provider_Identification>
					<xsl:if test="REF01">
						<Reference_Identification_Qualifier>
							<xsl:value-of select="REF01" />
						</Reference_Identification_Qualifier>
					</xsl:if>
					<xsl:if test="REF02">
						<Reference_Identification>
							<xsl:value-of select="REF02" />
						</Reference_Identification>
					</xsl:if>
				</Other_Payer_Referring_Provider_Identification>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2320/L2330/REF' and (REF01='1B' or REF01='EI' or REF01='G2')">
				<Other_Payer_Purchased_Service_Provider_Identification>
					<xsl:if test="REF01">
						<Reference_Identification_Qualifier>
							<xsl:value-of select="REF01" />
						</Reference_Identification_Qualifier>
					</xsl:if>
					<xsl:if test="REF02">
						<Reference_Identification>
							<xsl:value-of select="REF02" />
						</Reference_Identification>
					</xsl:if>
				</Other_Payer_Purchased_Service_Provider_Identification>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2320/L2330/REF' and (REF01='1B' or REF01='G2')">
				<Other_Payer_Service_Facility_Location_Identification>
					<xsl:if test="REF01">
						<Reference_Identification_Qualifier>
							<xsl:value-of select="REF01" />
						</Reference_Identification_Qualifier>
					</xsl:if>
					<xsl:if test="REF02">
						<Reference_Identification>
							<xsl:value-of select="REF02" />
						</Reference_Identification>
					</xsl:if>
				</Other_Payer_Service_Facility_Location_Identification>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2400/REF' and (REF01='6R')">
				<Line_Item_Control_Number>
					<xsl:if test="REF01">
						<Reference_Identification_Qualifier>
							<xsl:value-of select="REF01" />
						</Reference_Identification_Qualifier>
					</xsl:if>
					<xsl:if test="REF02">
						<Reference_Identification>
							<xsl:value-of select="REF02" />
						</Reference_Identification>
					</xsl:if>
				</Line_Item_Control_Number>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="DTP">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/DTP' and (DTP01='454')">
				<Initial_Treatment>
					<xsl:if test="DTP01">
						<Date_Time_Qualifier>
							<xsl:value-of select="DTP01" />
						</Date_Time_Qualifier>
					</xsl:if>
					<xsl:if test="DTP02">
						<Date_Time_Period_Format_Qualifier>
							<xsl:value-of select="DTP02" />
						</Date_Time_Period_Format_Qualifier>
					</xsl:if>
					<xsl:if test="DTP03">
						<Date_Time_Period>
							<xsl:value-of select="DTP03" />
						</Date_Time_Period>
					</xsl:if>
				</Initial_Treatment>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/DTP' and (DTP01='304')">
				<Date_Last_Seen>
					<xsl:if test="DTP01">
						<Date_Time_Qualifier>
							<xsl:value-of select="DTP01" />
						</Date_Time_Qualifier>
					</xsl:if>
					<xsl:if test="DTP02">
						<Date_Time_Period_Format_Qualifier>
							<xsl:value-of select="DTP02" />
						</Date_Time_Period_Format_Qualifier>
					</xsl:if>
					<xsl:if test="DTP03">
						<Date_Time_Period>
							<xsl:value-of select="DTP03" />
						</Date_Time_Period>
					</xsl:if>
				</Date_Last_Seen>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/DTP' and (DTP01='431')">
				<Onset_of_Current_Illness_Symptom>
					<xsl:if test="DTP01">
						<Date_Time_Qualifier>
							<xsl:value-of select="DTP01" />
						</Date_Time_Qualifier>
					</xsl:if>
					<xsl:if test="DTP02">
						<Date_Time_Period_Format_Qualifier>
							<xsl:value-of select="DTP02" />
						</Date_Time_Period_Format_Qualifier>
					</xsl:if>
					<xsl:if test="DTP03">
						<Date_Time_Period>
							<xsl:value-of select="DTP03" />
						</Date_Time_Period>
					</xsl:if>
				</Onset_of_Current_Illness_Symptom>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/DTP' and (DTP01='438')">
				<Similar_Illness_Symptom_Onset>
					<xsl:if test="DTP01">
						<Date_Time_Qualifier>
							<xsl:value-of select="DTP01" />
						</Date_Time_Qualifier>
					</xsl:if>
					<xsl:if test="DTP02">
						<Date_Time_Period_Format_Qualifier>
							<xsl:value-of select="DTP02" />
						</Date_Time_Period_Format_Qualifier>
					</xsl:if>
					<xsl:if test="DTP03">
						<Date_Time_Period>
							<xsl:value-of select="DTP03" />
						</Date_Time_Period>
					</xsl:if>
				</Similar_Illness_Symptom_Onset>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/DTP' and (DTP01='439')">
				<Accident>
					<xsl:if test="DTP01">
						<Date_Time_Qualifier>
							<xsl:value-of select="DTP01" />
						</Date_Time_Qualifier>
					</xsl:if>
					<xsl:if test="DTP02">
						<Date_Time_Period_Format_Qualifier>
							<xsl:value-of select="DTP02" />
						</Date_Time_Period_Format_Qualifier>
					</xsl:if>
					<xsl:if test="DTP03">
						<Date_Time_Period>
							<xsl:value-of select="DTP03" />
						</Date_Time_Period>
					</xsl:if>
				</Accident>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/DTP' and (DTP01='484')">
				<Last_Menstrual_Period>
					<xsl:if test="DTP01">
						<Date_Time_Qualifier>
							<xsl:value-of select="DTP01" />
						</Date_Time_Qualifier>
					</xsl:if>
					<xsl:if test="DTP02">
						<Date_Time_Period_Format_Qualifier>
							<xsl:value-of select="DTP02" />
						</Date_Time_Period_Format_Qualifier>
					</xsl:if>
					<xsl:if test="DTP03">
						<Date_Time_Period>
							<xsl:value-of select="DTP03" />
						</Date_Time_Period>
					</xsl:if>
				</Last_Menstrual_Period>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/DTP' and (DTP01='455')">
				<Last_X-ray>
					<xsl:if test="DTP01">
						<Date_Time_Qualifier>
							<xsl:value-of select="DTP01" />
						</Date_Time_Qualifier>
					</xsl:if>
					<xsl:if test="DTP02">
						<Date_Time_Period_Format_Qualifier>
							<xsl:value-of select="DTP02" />
						</Date_Time_Period_Format_Qualifier>
					</xsl:if>
					<xsl:if test="DTP03">
						<Date_Time_Period>
							<xsl:value-of select="DTP03" />
						</Date_Time_Period>
					</xsl:if>
				</Last_X-ray>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/DTP' and (DTP01='297')">
				<Last_Worked>
					<xsl:if test="DTP01">
						<Date_Time_Qualifier>
							<xsl:value-of select="DTP01" />
						</Date_Time_Qualifier>
					</xsl:if>
					<xsl:if test="DTP02">
						<Date_Time_Period_Format_Qualifier>
							<xsl:value-of select="DTP02" />
						</Date_Time_Period_Format_Qualifier>
					</xsl:if>
					<xsl:if test="DTP03">
						<Date_Time_Period>
							<xsl:value-of select="DTP03" />
						</Date_Time_Period>
					</xsl:if>
				</Last_Worked>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/DTP' and (DTP01='296')">
				<Authorized_Return_to_Work>
					<xsl:if test="DTP01">
						<Date_Time_Qualifier>
							<xsl:value-of select="DTP01" />
						</Date_Time_Qualifier>
					</xsl:if>
					<xsl:if test="DTP02">
						<Date_Time_Period_Format_Qualifier>
							<xsl:value-of select="DTP02" />
						</Date_Time_Period_Format_Qualifier>
					</xsl:if>
					<xsl:if test="DTP03">
						<Date_Time_Period>
							<xsl:value-of select="DTP03" />
						</Date_Time_Period>
					</xsl:if>
				</Authorized_Return_to_Work>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/DTP' and (DTP01='435')">
				<Admission>
					<xsl:if test="DTP01">
						<Date_Time_Qualifier>
							<xsl:value-of select="DTP01" />
						</Date_Time_Qualifier>
					</xsl:if>
					<xsl:if test="DTP02">
						<Date_Time_Period_Format_Qualifier>
							<xsl:value-of select="DTP02" />
						</Date_Time_Period_Format_Qualifier>
					</xsl:if>
					<xsl:if test="DTP03">
						<Date_Time_Period>
							<xsl:value-of select="DTP03" />
						</Date_Time_Period>
					</xsl:if>
				</Admission>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/DTP' and (DTP01='096')">
				<Discharge>
					<xsl:if test="DTP01">
						<Date_Time_Qualifier>
							<xsl:value-of select="DTP01" />
						</Date_Time_Qualifier>
					</xsl:if>
					<xsl:if test="DTP02">
						<Date_Time_Period_Format_Qualifier>
							<xsl:value-of select="DTP02" />
						</Date_Time_Period_Format_Qualifier>
					</xsl:if>
					<xsl:if test="DTP03">
						<Date_Time_Period>
							<xsl:value-of select="DTP03" />
						</Date_Time_Period>
					</xsl:if>
				</Discharge>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2320/L2330/DTP'">
				<Claim_Adjudication_Date>
					<xsl:if test="DTP01">
						<Date_Time_Qualifier>
							<xsl:value-of select="DTP01" />
						</Date_Time_Qualifier>
					</xsl:if>
					<xsl:if test="DTP02">
						<Date_Time_Period_Format_Qualifier>
							<xsl:value-of select="DTP02" />
						</Date_Time_Period_Format_Qualifier>
					</xsl:if>
					<xsl:if test="DTP03">
						<Date_Time_Period>
							<xsl:value-of select="DTP03" />
						</Date_Time_Period>
					</xsl:if>
				</Claim_Adjudication_Date>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2400/DTP' and (DTP01='472')">
				<Service_Date>
					<xsl:if test="DTP01">
						<Date_Time_Qualifier>
							<xsl:value-of select="DTP01" />
						</Date_Time_Qualifier>
					</xsl:if>
					<xsl:if test="DTP02">
						<Date_Time_Period_Format_Qualifier>
							<xsl:value-of select="DTP02" />
						</Date_Time_Period_Format_Qualifier>
					</xsl:if>
					<xsl:if test="DTP03">
						<Date_Time_Period>
							<xsl:value-of select="DTP03" />
						</Date_Time_Period>
					</xsl:if>
				</Service_Date>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2400/DTP' and (DTP01='738' or DTP01='739')">
				<Test_Date>
					<xsl:if test="DTP01">
						<Date_Time_Qualifier>
							<xsl:value-of select="DTP01" />
						</Date_Time_Qualifier>
					</xsl:if>
					<xsl:if test="DTP02">
						<Date_Time_Period_Format_Qualifier>
							<xsl:value-of select="DTP02" />
						</Date_Time_Period_Format_Qualifier>
					</xsl:if>
					<xsl:if test="DTP03">
						<Date_Time_Period>
							<xsl:value-of select="DTP03" />
						</Date_Time_Period>
					</xsl:if>
				</Test_Date>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2400/DTP' and (DTP01='119' or DTP01='480' or DTP01='481')">
				<Oxygen_Saturation_Arterial_Blood_Gas_Test>
					<xsl:if test="DTP01">
						<Date_Time_Qualifier>
							<xsl:value-of select="DTP01" />
						</Date_Time_Qualifier>
					</xsl:if>
					<xsl:if test="DTP02">
						<Date_Time_Period_Format_Qualifier>
							<xsl:value-of select="DTP02" />
						</Date_Time_Period_Format_Qualifier>
					</xsl:if>
					<xsl:if test="DTP03">
						<Date_Time_Period>
							<xsl:value-of select="DTP03" />
						</Date_Time_Period>
					</xsl:if>
				</Oxygen_Saturation_Arterial_Blood_Gas_Test>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2400/L2430/DTP'">
				<Line_Adjudication_Date>
					<xsl:if test="DTP01">
						<Date_Time_Qualifier>
							<xsl:value-of select="DTP01" />
						</Date_Time_Qualifier>
					</xsl:if>
					<xsl:if test="DTP02">
						<Date_Time_Period_Format_Qualifier>
							<xsl:value-of select="DTP02" />
						</Date_Time_Period_Format_Qualifier>
					</xsl:if>
					<xsl:if test="DTP03">
						<Date_Time_Period>
							<xsl:value-of select="DTP03" />
						</Date_Time_Period>
					</xsl:if>
				</Line_Adjudication_Date>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="CR1">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/CR1'">
				<Ambulance_Transport_Information>
					<xsl:if test="CR101">
						<Unit_Basis_for_Measurement_Code>
							<xsl:value-of select="CR101" />
						</Unit_Basis_for_Measurement_Code>
					</xsl:if>
					<xsl:if test="CR102">
						<Weight>
							<xsl:value-of select="CR102" />
						</Weight>
					</xsl:if>
					<xsl:if test="CR103">
						<Ambulance_Transport_Code>
							<xsl:value-of select="CR103" />
						</Ambulance_Transport_Code>
					</xsl:if>
					<xsl:if test="CR104">
						<Ambulance_Transport_Reason_Code>
							<xsl:value-of select="CR104" />
						</Ambulance_Transport_Reason_Code>
					</xsl:if>
					<xsl:if test="CR105">
						<Unit_Basis_for_Measurement_Code_2>
							<xsl:value-of select="CR105" />
						</Unit_Basis_for_Measurement_Code_2>
					</xsl:if>
					<xsl:if test="CR106">
						<Quantity>
							<xsl:value-of select="CR106" />
						</Quantity>
					</xsl:if>
					<xsl:if test="CR109">
						<Desciption>
							<xsl:value-of select="CR109" />
						</Desciption>
					</xsl:if>
					<xsl:if test="CR110">
						<Desciption_2>
							<xsl:value-of select="CR110" />
						</Desciption_2>
					</xsl:if>
				</Ambulance_Transport_Information>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="SE">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/SE'">
				<Transaction_Set_Trailer>
					<xsl:if test="SE01">
						<Number_of_Included_Segments>
							<xsl:value-of select="SE01" />
						</Number_of_Included_Segments>
					</xsl:if>
					<xsl:if test="SE02">
						<Transaction_Set_Control_Number>
							<xsl:value-of select="SE02" />
						</Transaction_Set_Control_Number>
					</xsl:if>
				</Transaction_Set_Trailer>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="CR5">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2400/CR5'">
				<Home_Oxygen_Therapy_Information>
					<xsl:if test="CR501">
						<Certification_Type_Code>
							<xsl:value-of select="CR501" />
						</Certification_Type_Code>
					</xsl:if>
					<xsl:if test="CR502">
						<Quantity>
							<xsl:value-of select="CR502" />
						</Quantity>
					</xsl:if>
					<xsl:if test="CR510">
						<Quantity_2>
							<xsl:value-of select="CR510" />
						</Quantity_2>
					</xsl:if>
					<xsl:if test="CR511">
						<Quantity_3>
							<xsl:value-of select="CR511" />
						</Quantity_3>
					</xsl:if>
					<xsl:if test="CR512">
						<Oxygen_Test_Condition_Code>
							<xsl:value-of select="CR512" />
						</Oxygen_Test_Condition_Code>
					</xsl:if>
					<xsl:if test="CR513">
						<Oxygen_Test_Findings_Code>
							<xsl:value-of select="CR513" />
						</Oxygen_Test_Findings_Code>
					</xsl:if>
					<xsl:if test="CR514">
						<Oxygen_Test_Findings_Code_2>
							<xsl:value-of select="CR514" />
						</Oxygen_Test_Findings_Code_2>
					</xsl:if>
					<xsl:if test="CR515">
						<Oxygen_Test_Findings_Code_3>
							<xsl:value-of select="CR515" />
						</Oxygen_Test_Findings_Code_3>
					</xsl:if>
				</Home_Oxygen_Therapy_Information>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="L1000">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L1000' and (NM1/NM101='41')">
				<L1000A>
					<xsl:apply-templates select="node()|@*" />
				</L1000A>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L1000' and (NM/NM101='40')">
				<L1000B>
					<xsl:apply-templates select="node()|@*" />
				</L1000B>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="CR7">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2305/CR7'">
				<Home_Health_Care_Plan_Information>
					<xsl:if test="CR701">
						<Discipline_Type_Code>
							<xsl:value-of select="CR701" />
						</Discipline_Type_Code>
					</xsl:if>
					<xsl:if test="CR702">
						<Number>
							<xsl:value-of select="CR702" />
						</Number>
					</xsl:if>
					<xsl:if test="CR703">
						<Number_2>
							<xsl:value-of select="CR703" />
						</Number_2>
					</xsl:if>
				</Home_Health_Care_Plan_Information>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="IEA">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/IEA'">
				<Interchange_Control_Trailer>
					<xsl:if test="IEA01">
						<Number_of_Included_Functional_Groups>
							<xsl:value-of select="IEA01" />
						</Number_of_Included_Functional_Groups>
					</xsl:if>
					<xsl:if test="IEA02">
						<Interchange_Control_Number>
							<xsl:value-of select="IEA02" />
						</Interchange_Control_Number>
					</xsl:if>
				</Interchange_Control_Trailer>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="L2305">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2305'">
				<L2305>
					<xsl:apply-templates select="node()|@*" />
				</L2305>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="PWK">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/PWK'">
				<Claim_Supplemental_Information>
					<xsl:if test="PWK01">
						<Report_Type_Code>
							<xsl:value-of select="PWK01" />
						</Report_Type_Code>
					</xsl:if>
					<xsl:if test="PWK02">
						<Report_Transmission_Code>
							<xsl:value-of select="PWK02" />
						</Report_Transmission_Code>
					</xsl:if>
					<xsl:if test="PWK05">
						<Identification_Code_Qualifier>
							<xsl:value-of select="PWK05" />
						</Identification_Code_Qualifier>
					</xsl:if>
					<xsl:if test="PWK06">
						<Identification_Code>
							<xsl:value-of select="PWK06" />
						</Identification_Code>
					</xsl:if>
				</Claim_Supplemental_Information>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="N3">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2010/N3'">
				<Patient_Address>
					<xsl:if test="N301">
						<Address_Information>
							<xsl:value-of select="N301" />
						</Address_Information>
					</xsl:if>
					<xsl:if test="N302">
						<Address_Information_2>
							<xsl:value-of select="N302" />
						</Address_Information_2>
					</xsl:if>
				</Patient_Address>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2310/N3'">
				<Service_Facility_Location_Address>
					<xsl:if test="N301">
						<Address_Information>
							<xsl:value-of select="N301" />
						</Address_Information>
					</xsl:if>
					<xsl:if test="N302">
						<Address_Information_2>
							<xsl:value-of select="N302" />
						</Address_Information_2>
					</xsl:if>
				</Service_Facility_Location_Address>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2320/L2330/N3'">
				<Other_Subscriber_Address>
					<xsl:if test="N301">
						<Address_Information>
							<xsl:value-of select="N301" />
						</Address_Information>
					</xsl:if>
					<xsl:if test="N302">
						<Address_Information_2>
							<xsl:value-of select="N302" />
						</Address_Information_2>
					</xsl:if>
				</Other_Subscriber_Address>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="L2010">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2010' and (NM1/NM101='85')">
				<L2010AA>
					<xsl:apply-templates select="node()|@*" />
				</L2010AA>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2010' and (NM1/NM101='IL')">
				<L2010BA>
					<xsl:apply-templates select="node()|@*" />
				</L2010BA>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2010' and (NM1/NM101='PR')">
				<L2010BB>
					<xsl:apply-templates select="node()|@*" />
				</L2010BB>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2010'">
				<L2010CA>
					<xsl:apply-templates select="node()|@*" />
				</L2010CA>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="N4">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2010/N4'">
				<Patient_City_State_ZIP_Code>
					<xsl:if test="N401">
						<City_Name>
							<xsl:value-of select="N401" />
						</City_Name>
					</xsl:if>
					<xsl:if test="N402">
						<State_Province_Code>
							<xsl:value-of select="N402" />
						</State_Province_Code>
					</xsl:if>
					<xsl:if test="N403">
						<Postal_Code>
							<xsl:value-of select="N403" />
						</Postal_Code>
					</xsl:if>
					<xsl:if test="N404">
						<Country_Code>
							<xsl:value-of select="N404" />
						</Country_Code>
					</xsl:if>
				</Patient_City_State_ZIP_Code>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2310/N4'">
				<Service_Facility_Location_City_State_ZIP>
					<xsl:if test="N401">
						<City_Name>
							<xsl:value-of select="N401" />
						</City_Name>
					</xsl:if>
					<xsl:if test="N402">
						<State_or_Province_Code>
							<xsl:value-of select="N402" />
						</State_or_Province_Code>
					</xsl:if>
					<xsl:if test="N403">
						<Postal_Code>
							<xsl:value-of select="N403" />
						</Postal_Code>
					</xsl:if>
					<xsl:if test="N404">
						<Country_Code>
							<xsl:value-of select="N404" />
						</Country_Code>
					</xsl:if>
				</Service_Facility_Location_City_State_ZIP>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2320/L2330/N4'">
				<Other_Subscriber_City_State_ZIP_Code>
					<xsl:if test="N401">
						<City_Name>
							<xsl:value-of select="N401" />
						</City_Name>
					</xsl:if>
					<xsl:if test="N402">
						<State_or_Province_Code>
							<xsl:value-of select="N402" />
						</State_or_Province_Code>
					</xsl:if>
					<xsl:if test="N403">
						<Postal_Code>
							<xsl:value-of select="N403" />
						</Postal_Code>
					</xsl:if>
					<xsl:if test="N404">
						<Country_Code>
							<xsl:value-of select="N404" />
						</Country_Code>
					</xsl:if>
				</Other_Subscriber_City_State_ZIP_Code>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="SBR">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/SBR'">
				<Subscriber_Information>
					<xsl:if test="SBR01">
						<Payer_Responsibility_Sequence_Number_Code>
							<xsl:value-of select="SBR01" />
						</Payer_Responsibility_Sequence_Number_Code>
					</xsl:if>
					<xsl:if test="SBR02">
						<Individual_Relationship_Code>
							<xsl:value-of select="SBR02" />
						</Individual_Relationship_Code>
					</xsl:if>
					<xsl:if test="SBR03">
						<Reference_Identification>
							<xsl:value-of select="SBR03" />
						</Reference_Identification>
					</xsl:if>
					<xsl:if test="SBR09">
						<Claim_Filing_Indicator_Code>
							<xsl:value-of select="SBR09" />
						</Claim_Filing_Indicator_Code>
					</xsl:if>
				</Subscriber_Information>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2320/SBR'">
				<Other_Subscriber_Information>
					<xsl:if test="SBR01">
						<Payer_Responsibility_Sequence_Number_Code>
							<xsl:value-of select="SBR01" />
						</Payer_Responsibility_Sequence_Number_Code>
					</xsl:if>
					<xsl:if test="SBR02">
						<Individual_Relationship_Code>
							<xsl:value-of select="SBR02" />
						</Individual_Relationship_Code>
					</xsl:if>
					<xsl:if test="SBR03">
						<Reference_Identification>
							<xsl:value-of select="SBR03" />
						</Reference_Identification>
					</xsl:if>
					<xsl:if test="SBR04">
						<Name>
							<xsl:value-of select="SBR04" />
						</Name>
					</xsl:if>
					<xsl:if test="SBR05">
						<Insurance_Type_Code>
							<xsl:value-of select="SBR05" />
						</Insurance_Type_Code>
					</xsl:if>
					<xsl:if test="SBR09">
						<Claim_Filing_Indicator_Code>
							<xsl:value-of select="SBR09" />
						</Claim_Filing_Indicator_Code>
					</xsl:if>
				</Other_Subscriber_Information>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="PAT">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/PAT'">
				<Patient_Information>
					<xsl:if test="PAT01">
						<Individual_Relationship_Code>
							<xsl:value-of select="PAT01" />
						</Individual_Relationship_Code>
					</xsl:if>
					<xsl:if test="PAT05">
						<Date_Time_Period_Format_Qualifier>
							<xsl:value-of select="PAT05" />
						</Date_Time_Period_Format_Qualifier>
					</xsl:if>
					<xsl:if test="PAT06">
						<Date_Time_Period>
							<xsl:value-of select="PAT06" />
						</Date_Time_Period>
					</xsl:if>
					<xsl:if test="PAT07">
						<Unit_Basis_for_Measurement_Code>
							<xsl:value-of select="PAT07" />
						</Unit_Basis_for_Measurement_Code>
					</xsl:if>
					<xsl:if test="PAT08">
						<Weight>
							<xsl:value-of select="PAT08" />
						</Weight>
					</xsl:if>
					<xsl:if test="PAT09">
						<Condition_Response_Code>
							<xsl:value-of select="PAT09" />
						</Condition_Response_Code>
					</xsl:if>
				</Patient_Information>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="HSD">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2305/HSD'">
				<Health_Care_Services_Delivery>
					<xsl:if test="HSD01">
						<Quantity_Qualifier>
							<xsl:value-of select="HSD01" />
						</Quantity_Qualifier>
					</xsl:if>
					<xsl:if test="HSD02">
						<Quantity>
							<xsl:value-of select="HSD02" />
						</Quantity>
					</xsl:if>
					<xsl:if test="HSD03">
						<Unit_Basis_for_Measurement_Code>
							<xsl:value-of select="HSD03" />
						</Unit_Basis_for_Measurement_Code>
					</xsl:if>
					<xsl:if test="HSD04">
						<Sample_Selection_Modulus>
							<xsl:value-of select="HSD04" />
						</Sample_Selection_Modulus>
					</xsl:if>
					<xsl:if test="HSD05">
						<Time_Period_Qualifier>
							<xsl:value-of select="HSD05" />
						</Time_Period_Qualifier>
					</xsl:if>
					<xsl:if test="HSD06">
						<Number_of_Periods>
							<xsl:value-of select="HSD06" />
						</Number_of_Periods>
					</xsl:if>
					<xsl:if test="HSD07">
						<Ship_Delivery_or_Calendar_Pattern_Code>
							<xsl:value-of select="HSD07" />
						</Ship_Delivery_or_Calendar_Pattern_Code>
					</xsl:if>
					<xsl:if test="HSD08">
						<Ship_Delivery_Pattern_Time_Code>
							<xsl:value-of select="HSD08" />
						</Ship_Delivery_Pattern_Time_Code>
					</xsl:if>
				</Health_Care_Services_Delivery>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="MEA">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2400/MEA'">
				<Test_Result>
					<xsl:if test="MEA01">
						<Measurement_Reference_ID_Code>
							<xsl:value-of select="MEA01" />
						</Measurement_Reference_ID_Code>
					</xsl:if>
					<xsl:if test="MEA02">
						<Measurement_Qualifier>
							<xsl:value-of select="MEA02" />
						</Measurement_Qualifier>
					</xsl:if>
					<xsl:if test="MEA03">
						<Measurement_Value>
							<xsl:value-of select="MEA03" />
						</Measurement_Value>
					</xsl:if>
				</Test_Result>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="GS">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/GS'">
				<Functional_Group_Header>
					<xsl:if test="GS01">
						<Functional_Identifier_Code>
							<xsl:value-of select="GS01" />
						</Functional_Identifier_Code>
					</xsl:if>
					<xsl:if test="GS02">
						<Application_Sender_Code>
							<xsl:value-of select="GS02" />
						</Application_Sender_Code>
					</xsl:if>
					<xsl:if test="GS03">
						<Application_Receiver_Code>
							<xsl:value-of select="GS03" />
						</Application_Receiver_Code>
					</xsl:if>
					<xsl:if test="GS04">
						<Date>
							<xsl:value-of select="GS04" />
						</Date>
					</xsl:if>
					<xsl:if test="GS05">
						<Time>
							<xsl:value-of select="GS05" />
						</Time>
					</xsl:if>
					<xsl:if test="GS06">
						<Group_Control_Number>
							<xsl:value-of select="GS06" />
						</Group_Control_Number>
					</xsl:if>
					<xsl:if test="GS07">
						<Responsible_Agency_Code>
							<xsl:value-of select="GS07" />
						</Responsible_Agency_Code>
					</xsl:if>
					<xsl:if test="GS08">
						<Version_Release_Industry_Identifier_Code>
							<xsl:value-of select="GS08" />
						</Version_Release_Industry_Identifier_Code>
					</xsl:if>
				</Functional_Group_Header>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="SVD">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2400/L2430/SVD'">
				<Line_Adjudication_Information>
					<xsl:if test="SVD01">
						<Identification_Code>
							<xsl:value-of select="SVD01" />
						</Identification_Code>
					</xsl:if>
					<xsl:if test="SVD02">
						<Monetary_Amount>
							<xsl:value-of select="SVD02" />
						</Monetary_Amount>
					</xsl:if>
					<xsl:if test="SVD03">
						<Composite_Medical_Procedure_Identifier>
							<xsl:if test="SVD03/SVD031">
								<Product_Service_ID_Qualifier>
									<xsl:value-of select="SVD03/SVD031" />
								</Product_Service_ID_Qualifier>
							</xsl:if>
							<xsl:if test="SVD03/SVD032">
								<Product_Service_ID>
									<xsl:value-of select="SVD03/SVD032" />
								</Product_Service_ID>
							</xsl:if>
							<xsl:if test="SVD03/SVD033">
								<Procedure_Modifier>
									<xsl:value-of select="SVD03/SVD033" />
								</Procedure_Modifier>
							</xsl:if>
							<xsl:if test="SVD03/SVD034">
								<Procedure_Modifier>
									<xsl:value-of select="SVD03/SVD034" />
								</Procedure_Modifier>
							</xsl:if>
							<xsl:if test="SVD03/SVD035">
								<Procedure_Modifier>
									<xsl:value-of select="SVD03/SVD035" />
								</Procedure_Modifier>
							</xsl:if>
							<xsl:if test="SVD03/SVD036">
								<Procedure_Modifier>
									<xsl:value-of select="SVD03/SVD036" />
								</Procedure_Modifier>
							</xsl:if>
							<xsl:if test="SVD03/SVD037">
								<Description>
									<xsl:value-of select="SVD03/SVD037" />
								</Description>
							</xsl:if>
						</Composite_Medical_Procedure_Identifier>
					</xsl:if>
					<xsl:if test="SVD05">
						<Quantity>
							<xsl:value-of select="SVD05" />
						</Quantity>
					</xsl:if>
					<xsl:if test="SVD06">
						<Assigned_Number>
							<xsl:value-of select="SVD06" />
						</Assigned_Number>
					</xsl:if>
				</Line_Adjudication_Information>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="L2300">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300'">
				<L2300>
					<xsl:apply-templates select="node()|@*" />
				</L2300>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="CRC">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/CRC' and (CRC101='07')">
				<Ambulance_Certification>
					<xsl:if test="CRC01">
						<Code_Category>
							<xsl:value-of select="CRC01" />
						</Code_Category>
					</xsl:if>
					<xsl:if test="CRC02">
						<Condition_Response_Code>
							<xsl:value-of select="CRC02" />
						</Condition_Response_Code>
					</xsl:if>
					<xsl:if test="CRC03">
						<Condition_Indicator>
							<xsl:value-of select="CRC03" />
						</Condition_Indicator>
					</xsl:if>
					<xsl:if test="CRC04">
						<Condition_Indicator_2>
							<xsl:value-of select="CRC04" />
						</Condition_Indicator_2>
					</xsl:if>
					<xsl:if test="CRC05">
						<Condition_Indicator_3>
							<xsl:value-of select="CRC05" />
						</Condition_Indicator_3>
					</xsl:if>
					<xsl:if test="CRC06">
						<Condition_Indicator_4>
							<xsl:value-of select="CRC06" />
						</Condition_Indicator_4>
					</xsl:if>
					<xsl:if test="CRC07">
						<Condition_Indicator_5>
							<xsl:value-of select="CRC07" />
						</Condition_Indicator_5>
					</xsl:if>
				</Ambulance_Certification>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/CRC' and (CRC101='ZZ')">
				<EPSDT_Referral>
					<xsl:if test="CRC01">
						<Code_Category>
							<xsl:value-of select="CRC01" />
						</Code_Category>
					</xsl:if>
					<xsl:if test="CRC02">
						<Condition_Response_Code>
							<xsl:value-of select="CRC02" />
						</Condition_Response_Code>
					</xsl:if>
					<xsl:if test="CRC03">
						<Condition_Indicator>
							<xsl:value-of select="CRC03" />
						</Condition_Indicator>
					</xsl:if>
					<xsl:if test="CRC04">
						<Condition_Indicator_2>
							<xsl:value-of select="CRC04" />
						</Condition_Indicator_2>
					</xsl:if>
					<xsl:if test="CRC05">
						<Condition_Indicator_3>
							<xsl:value-of select="CRC05" />
						</Condition_Indicator_3>
					</xsl:if>
				</EPSDT_Referral>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2400/CRC'">
				<DMERC_Condition_Indicator>
					<xsl:if test="CRC01">
						<Code_Category>
							<xsl:value-of select="CRC01" />
						</Code_Category>
					</xsl:if>
					<xsl:if test="CRC02">
						<Condition_Response_Code>
							<xsl:value-of select="CRC02" />
						</Condition_Response_Code>
					</xsl:if>
					<xsl:if test="CRC03">
						<Condition_Indicator>
							<xsl:value-of select="CRC03" />
						</Condition_Indicator>
					</xsl:if>
					<xsl:if test="CRC04">
						<Condition_Indicator_2>
							<xsl:value-of select="CRC04" />
						</Condition_Indicator_2>
					</xsl:if>
					<xsl:if test="CRC05">
						<Condition_Indicator_3>
							<xsl:value-of select="CRC05" />
						</Condition_Indicator_3>
					</xsl:if>
					<xsl:if test="CRC06">
						<Condition_Indicator_4>
							<xsl:value-of select="CRC06" />
						</Condition_Indicator_4>
					</xsl:if>
					<xsl:if test="CRC07">
						<Condition_Indicator_5>
							<xsl:value-of select="CRC07" />
						</Condition_Indicator_5>
					</xsl:if>
				</DMERC_Condition_Indicator>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="NM1">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L1000/NM1' and (NM101='41')">
				<Submitter_Name>
					<xsl:if test="NM101">
						<Entity_Identifier_Code>
							<xsl:value-of select="NM101" />
						</Entity_Identifier_Code>
					</xsl:if>
					<xsl:if test="NM102">
						<Entity_Type_Qualifier>
							<xsl:value-of select="NM102" />
						</Entity_Type_Qualifier>
					</xsl:if>
					<xsl:if test="NM103">
						<Name_Last_Organization_Name>
							<xsl:value-of select="NM103" />
						</Name_Last_Organization_Name>
					</xsl:if>
					<xsl:if test="NM104">
						<Name_First>
							<xsl:value-of select="NM104" />
						</Name_First>
					</xsl:if>
					<xsl:if test="NM105">
						<Name_Middle>
							<xsl:value-of select="NM105" />
						</Name_Middle>
					</xsl:if>
					<xsl:if test="NM108">
						<Identification_Code_Qualifier>
							<xsl:value-of select="NM108" />
						</Identification_Code_Qualifier>
					</xsl:if>
					<xsl:if test="NM109">
						<Identification_Code>
							<xsl:value-of select="NM109" />
						</Identification_Code>
					</xsl:if>
				</Submitter_Name>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L1000/NM1' and (NM101='40')">
				<Receiver_Name>
					<xsl:if test="NM101">
						<Entity_Identifier_Code>
							<xsl:value-of select="NM101" />
						</Entity_Identifier_Code>
					</xsl:if>
					<xsl:if test="NM102">
						<Entity_Type_Qualifier>
							<xsl:value-of select="NM102" />
						</Entity_Type_Qualifier>
					</xsl:if>
					<xsl:if test="NM103">
						<Name_Organization_Name>
							<xsl:value-of select="NM103" />
						</Name_Organization_Name>
					</xsl:if>
					<xsl:if test="NM108">
						<Identification_Code_Qualifier>
							<xsl:value-of select="NM108" />
						</Identification_Code_Qualifier>
					</xsl:if>
					<xsl:if test="NM109">
						<Identification_Code>
							<xsl:value-of select="NM109" />
						</Identification_Code>
					</xsl:if>
				</Receiver_Name>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2010/NM1' and (NM101='85')">
				<Billing_Provider_Name>
					<xsl:if test="NM101">
						<Entity_Identifier_Code>
							<xsl:value-of select="NM101" />
						</Entity_Identifier_Code>
					</xsl:if>
					<xsl:if test="NM102">
						<Entity_Type_Qualifier>
							<xsl:value-of select="NM102" />
						</Entity_Type_Qualifier>
					</xsl:if>
					<xsl:if test="NM103">
						<Name_Last_Organization_Name>
							<xsl:value-of select="NM103" />
						</Name_Last_Organization_Name>
					</xsl:if>
					<xsl:if test="NM104">
						<Name_First>
							<xsl:value-of select="NM104" />
						</Name_First>
					</xsl:if>
					<xsl:if test="NM105">
						<Name_Middle>
							<xsl:value-of select="NM105" />
						</Name_Middle>
					</xsl:if>
					<xsl:if test="NM107">
						<Name_Suffix>
							<xsl:value-of select="NM107" />
						</Name_Suffix>
					</xsl:if>
					<xsl:if test="NM108">
						<Identification_Code_Qualifier>
							<xsl:value-of select="NM108" />
						</Identification_Code_Qualifier>
					</xsl:if>
					<xsl:if test="NM109">
						<Identification_Code>
							<xsl:value-of select="NM109" />
						</Identification_Code>
					</xsl:if>
				</Billing_Provider_Name>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2010/NM1' and (NM101='IL')">
				<Subscriber_Name>
					<xsl:if test="NM101">
						<Entity_Identifier_Code>
							<xsl:value-of select="NM101" />
						</Entity_Identifier_Code>
					</xsl:if>
					<xsl:if test="NM102">
						<Entity_Type_Qualifier>
							<xsl:value-of select="NM102" />
						</Entity_Type_Qualifier>
					</xsl:if>
					<xsl:if test="NM103">
						<Name_Last_Organization_Name>
							<xsl:value-of select="NM103" />
						</Name_Last_Organization_Name>
					</xsl:if>
					<xsl:if test="NM104">
						<Name_First>
							<xsl:value-of select="NM104" />
						</Name_First>
					</xsl:if>
					<xsl:if test="NM105">
						<Name_Middle>
							<xsl:value-of select="NM105" />
						</Name_Middle>
					</xsl:if>
					<xsl:if test="NM107">
						<Name_Suffix>
							<xsl:value-of select="NM107" />
						</Name_Suffix>
					</xsl:if>
					<xsl:if test="NM108">
						<Identification_Code_Qualifier>
							<xsl:value-of select="NM108" />
						</Identification_Code_Qualifier>
					</xsl:if>
					<xsl:if test="NM109">
						<Identification_Code>
							<xsl:value-of select="NM109" />
						</Identification_Code>
					</xsl:if>
				</Subscriber_Name>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2010/NM1' and (NM101='PR')">
				<Payer_Name>
					<xsl:if test="NM101">
						<Entity_Identifier_Code>
							<xsl:value-of select="NM101" />
						</Entity_Identifier_Code>
					</xsl:if>
					<xsl:if test="NM102">
						<Entity_Type_Qualifier>
							<xsl:value-of select="NM102" />
						</Entity_Type_Qualifier>
					</xsl:if>
					<xsl:if test="NM103">
						<Name_Last_Organization_Name>
							<xsl:value-of select="NM103" />
						</Name_Last_Organization_Name>
					</xsl:if>
					<xsl:if test="NM108">
						<Identification_Code_Qualifier>
							<xsl:value-of select="NM108" />
						</Identification_Code_Qualifier>
					</xsl:if>
					<xsl:if test="NM109">
						<Identification_Code>
							<xsl:value-of select="NM109" />
						</Identification_Code>
					</xsl:if>
				</Payer_Name>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2010/NM1' and (NM101='QC')">
				<Patient_Name>
					<xsl:if test="NM101">
						<Entity_Identifier_Code>
							<xsl:value-of select="NM101" />
						</Entity_Identifier_Code>
					</xsl:if>
					<xsl:if test="NM102">
						<Entity_Type_Qualifier>
							<xsl:value-of select="NM102" />
						</Entity_Type_Qualifier>
					</xsl:if>
					<xsl:if test="NM103">
						<Name_Last_Organization_Name>
							<xsl:value-of select="NM103" />
						</Name_Last_Organization_Name>
					</xsl:if>
					<xsl:if test="NM104">
						<Name_First>
							<xsl:value-of select="NM104" />
						</Name_First>
					</xsl:if>
					<xsl:if test="NM105">
						<Name_Middle>
							<xsl:value-of select="NM105" />
						</Name_Middle>
					</xsl:if>
					<xsl:if test="NM107">
						<Name_Suffix>
							<xsl:value-of select="NM107" />
						</Name_Suffix>
					</xsl:if>
					<xsl:if test="NM108">
						<Identification_Code_Qualifier>
							<xsl:value-of select="NM108" />
						</Identification_Code_Qualifier>
					</xsl:if>
					<xsl:if test="NM109">
						<Identification_Code>
							<xsl:value-of select="NM109" />
						</Identification_Code>
					</xsl:if>
				</Patient_Name>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2310/NM1' and (NM101='DN' or NM101='P3')">
				<Referring_Provider_Name>
					<xsl:if test="NM101">
						<Entity_Identifier_Code>
							<xsl:value-of select="NM101" />
						</Entity_Identifier_Code>
					</xsl:if>
					<xsl:if test="NM102">
						<Entity_Type_Qualifier>
							<xsl:value-of select="NM102" />
						</Entity_Type_Qualifier>
					</xsl:if>
					<xsl:if test="NM103">
						<Name_Last_or_Organization_Name>
							<xsl:value-of select="NM103" />
						</Name_Last_or_Organization_Name>
					</xsl:if>
					<xsl:if test="NM104">
						<Name_First>
							<xsl:value-of select="NM104" />
						</Name_First>
					</xsl:if>
					<xsl:if test="NM105">
						<Name_Middle>
							<xsl:value-of select="NM105" />
						</Name_Middle>
					</xsl:if>
					<xsl:if test="NM107">
						<Name_Suffix>
							<xsl:value-of select="NM107" />
						</Name_Suffix>
					</xsl:if>
					<xsl:if test="NM108">
						<Identification_Code_Qualifier>
							<xsl:value-of select="NM108" />
						</Identification_Code_Qualifier>
					</xsl:if>
					<xsl:if test="NM109">
						<Identification_Code>
							<xsl:value-of select="NM109" />
						</Identification_Code>
					</xsl:if>
				</Referring_Provider_Name>
			</xsl:when>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2310/NM1' and (NM101='82')">
				<Rendering_Provider_Name>
					<xsl:if test="NM101">
						<Entity_Identifier_Code>
							<xsl:value-of select="NM101" />
						</Entity_Identifier_Code>
					</xsl:if>
					<xsl:if test="NM102">
						<Entity_Type_Qualifier>
							<xsl:value-of select="NM102" />
						</Entity_Type_Qualifier>
					</xsl:if>
					<xsl:if test="NM103">
						<Name_Last_or_Organization_Name>
							<xsl:value-of select="NM103" />
						</Name_Last_or_Organization_Name>
					</xsl:if>
					<xsl:if test="NM104">
						<Name_First>
							<xsl:value-of select="NM104" />
						</Name_First>
					</xsl:if>
					<xsl:if test="NM105">
						<Name_Middle>
							<xsl:value-of select="NM105" />
						</Name_Middle>
					</xsl:if>
					<xsl:if test="NM107">
						<Name_Suffix>
							<xsl:value-of select="NM107" />
						</Name_Suffix>
					</xsl:if>
					<xsl:if test="NM108">
						<Identification_Code_Qualifier>
							<xsl:value-of select="NM108" />
						</Identification_Code_Qualifier>
					</xsl:if>
					<xsl:if test="NM109">
						<Identification_Code>
							<xsl:value-of select="NM109" />
						</Identification_Code>
					</xsl:if>
				</Rendering_Provider_Name>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2310/NM1' and (NM101='77' or NM101='FA' or NM101='LI' or NM101='TL')">
				<Service_Facility_Location>
					<xsl:if test="NM101">
						<Entity_Identifier_Code>
							<xsl:value-of select="NM101" />
						</Entity_Identifier_Code>
					</xsl:if>
					<xsl:if test="NM102">
						<Entity_Type_Qualifier>
							<xsl:value-of select="NM102" />
						</Entity_Type_Qualifier>
					</xsl:if>
					<xsl:if test="NM103">
						<Name_Last_or_Organization_Name>
							<xsl:value-of select="NM103" />
						</Name_Last_or_Organization_Name>
					</xsl:if>
					<xsl:if test="NM108">
						<Identification_Code_Qualifier>
							<xsl:value-of select="NM108" />
						</Identification_Code_Qualifier>
					</xsl:if>
					<xsl:if test="NM109">
						<Identification_Code>
							<xsl:value-of select="NM109" />
						</Identification_Code>
					</xsl:if>
				</Service_Facility_Location>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2320/L2330/NM1' and (NM101='IL')">
				<Other_Subscriber_Name>
					<xsl:if test="NM101">
						<Entity_Identifier_Code>
							<xsl:value-of select="NM101" />
						</Entity_Identifier_Code>
					</xsl:if>
					<xsl:if test="NM102">
						<Entity_Type_Qualifier>
							<xsl:value-of select="NM102" />
						</Entity_Type_Qualifier>
					</xsl:if>
					<xsl:if test="NM103">
						<Name_Last_or_Organization_Name>
							<xsl:value-of select="NM103" />
						</Name_Last_or_Organization_Name>
					</xsl:if>
					<xsl:if test="NM104">
						<Name_First>
							<xsl:value-of select="NM104" />
						</Name_First>
					</xsl:if>
					<xsl:if test="NM105">
						<Name_Middle>
							<xsl:value-of select="NM105" />
						</Name_Middle>
					</xsl:if>
					<xsl:if test="NM107">
						<Name_Suffix>
							<xsl:value-of select="NM107" />
						</Name_Suffix>
					</xsl:if>
					<xsl:if test="NM108">
						<Identification_Code_Qualifier>
							<xsl:value-of select="NM108" />
						</Identification_Code_Qualifier>
					</xsl:if>
					<xsl:if test="NM109">
						<Identification_Code>
							<xsl:value-of select="NM109" />
						</Identification_Code>
					</xsl:if>
				</Other_Subscriber_Name>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2320/L2330/NM1' and (NM101='PR')">
				<Other_Payer_Name>
					<xsl:if test="NM101">
						<Entity_Identifier_Code>
							<xsl:value-of select="NM101" />
						</Entity_Identifier_Code>
					</xsl:if>
					<xsl:if test="NM102">
						<Entity_Type_Qualifier>
							<xsl:value-of select="NM102" />
						</Entity_Type_Qualifier>
					</xsl:if>
					<xsl:if test="NM103">
						<Name_Last_or_Organization_Name>
							<xsl:value-of select="NM103" />
						</Name_Last_or_Organization_Name>
					</xsl:if>
					<xsl:if test="NM108">
						<Identification_Code_Qualifier>
							<xsl:value-of select="NM108" />
						</Identification_Code_Qualifier>
					</xsl:if>
					<xsl:if test="NM109">
						<Identification_Code>
							<xsl:value-of select="NM109" />
						</Identification_Code>
					</xsl:if>
				</Other_Payer_Name>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2320/L2330/NM1' and (NM101='QC')">
				<Other_Payer_Patient_Information>
					<xsl:if test="NM101">
						<Entity_Identifier_Code>
							<xsl:value-of select="NM101" />
						</Entity_Identifier_Code>
					</xsl:if>
					<xsl:if test="NM102">
						<Entity_Type_Qualifier>
							<xsl:value-of select="NM102" />
						</Entity_Type_Qualifier>
					</xsl:if>
					<xsl:if test="NM108">
						<Identification_Code_Qualifier>
							<xsl:value-of select="NM108" />
						</Identification_Code_Qualifier>
					</xsl:if>
					<xsl:if test="NM109">
						<Identification_Code>
							<xsl:value-of select="NM109" />
						</Identification_Code>
					</xsl:if>
				</Other_Payer_Patient_Information>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2320/L2330/NM1' and (NM101='DN' or NM101='P3')">
				<Other_Payer_Referring_Provider>
					<xsl:if test="NM101">
						<Entity_Identifier_Code>
							<xsl:value-of select="NM101" />
						</Entity_Identifier_Code>
					</xsl:if>
					<xsl:if test="NM102">
						<Entity_Type_Qualifier>
							<xsl:value-of select="NM102" />
						</Entity_Type_Qualifier>
					</xsl:if>
				</Other_Payer_Referring_Provider>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2320/L2330/NM1' and (NM101='82')">
				<Other_Payer_Rendering_Provider>
					<xsl:if test="NM101">
						<Entity_Identifier_Code>
							<xsl:value-of select="NM101" />
						</Entity_Identifier_Code>
					</xsl:if>
					<xsl:if test="NM102">
						<Entity_Type_Qualifier>
							<xsl:value-of select="NM102" />
						</Entity_Type_Qualifier>
					</xsl:if>
				</Other_Payer_Rendering_Provider>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2320/L2330/NM1' and (NM101='QB')">
				<Other_Payer_Purchased_Service_Provider>
					<xsl:if test="NM101">
						<Entity_Identifier_Code>
							<xsl:value-of select="NM101" />
						</Entity_Identifier_Code>
					</xsl:if>
					<xsl:if test="NM102">
						<Entity_Type_Qualifier>
							<xsl:value-of select="NM102" />
						</Entity_Type_Qualifier>
					</xsl:if>
				</Other_Payer_Purchased_Service_Provider>
			</xsl:when>
			<xsl:when
				test="$xPath='/ediroot/L2000/L2300/L2320/L2330/NM1' and (NM101='77' or NM101='FA' or NM101='LI' or NM101='TL')">
				<Other_Payer_Service_Facility_Location>
					<xsl:if test="NM101">
						<Entity_Identifier_Code>
							<xsl:value-of select="NM101" />
						</Entity_Identifier_Code>
					</xsl:if>
					<xsl:if test="NM102">
						<Entity_Type_Qualifier>
							<xsl:value-of select="NM102" />
						</Entity_Type_Qualifier>
					</xsl:if>
				</Other_Payer_Service_Facility_Location>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="ISA">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/ISA'">
				<Interchange_Control_Header>
					<xsl:if test="ISA01">
						<Authorization_Information_Qualifier>
							<xsl:value-of select="ISA01" />
						</Authorization_Information_Qualifier>
					</xsl:if>
					<xsl:if test="ISA02">
						<Authorization_Information>
							<xsl:value-of select="ISA02" />
						</Authorization_Information>
					</xsl:if>
					<xsl:if test="ISA03">
						<Security_Information_Qualifier>
							<xsl:value-of select="ISA03" />
						</Security_Information_Qualifier>
					</xsl:if>
					<xsl:if test="ISA04">
						<Security_Information>
							<xsl:value-of select="ISA04" />
						</Security_Information>
					</xsl:if>
					<xsl:if test="ISA05">
						<Interchange_Sender_ID_Qualifier>
							<xsl:value-of select="ISA05" />
						</Interchange_Sender_ID_Qualifier>
					</xsl:if>
					<xsl:if test="ISA06">
						<Interchange_Sender_ID>
							<xsl:value-of select="ISA06" />
						</Interchange_Sender_ID>
					</xsl:if>
					<xsl:if test="ISA07">
						<Interchange_Receiver_ID_Qualifier>
							<xsl:value-of select="ISA07" />
						</Interchange_Receiver_ID_Qualifier>
					</xsl:if>
					<xsl:if test="ISA08">
						<Interchange_Receiver_ID>
							<xsl:value-of select="ISA08" />
						</Interchange_Receiver_ID>
					</xsl:if>
					<xsl:if test="ISA09">
						<Interchange_Date>
							<xsl:value-of select="ISA09" />
						</Interchange_Date>
					</xsl:if>
					<xsl:if test="ISA10">
						<Interchange_Time>
							<xsl:value-of select="ISA10" />
						</Interchange_Time>
					</xsl:if>
					<xsl:if test="ISA11">
						<Interchange_Control_Standards_Identifier>
							<xsl:value-of select="ISA11" />
						</Interchange_Control_Standards_Identifier>
					</xsl:if>
					<xsl:if test="ISA12">
						<Interchange_Control_Version_Number>
							<xsl:value-of select="ISA12" />
						</Interchange_Control_Version_Number>
					</xsl:if>
					<xsl:if test="ISA13">
						<Interchange_Control_Number>
							<xsl:value-of select="ISA13" />
						</Interchange_Control_Number>
					</xsl:if>
					<xsl:if test="ISA14">
						<Acknowledgment_Requested>
							<xsl:value-of select="ISA14" />
						</Acknowledgment_Requested>
					</xsl:if>
					<xsl:if test="ISA15">
						<Usage_Indicator>
							<xsl:value-of select="ISA15" />
						</Usage_Indicator>
					</xsl:if>
					<xsl:if test="ISA16">
						<Component_Element_Separator>
							<xsl:value-of select="ISA16" />
						</Component_Element_Separator>
					</xsl:if>
				</Interchange_Control_Header>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="L2400">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2400'">
				<L2400>
					<xsl:apply-templates select="node()|@*" />
				</L2400>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="L2320">
		<xsl:variable name="xPath">
			<xsl:call-template name="getXPath" />
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$xPath='/ediroot/L2000/L2300/L2320'">
				<L2320>
					<xsl:apply-templates select="node()|@*" />
				</L2320>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="node()|@*" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>