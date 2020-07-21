package com.quantum.survey.dao;

import com.quantum.survey.po.PaperUserRelationships;

public interface PaperUserRelationShipsDao{
	int addPaperUserRelationships(PaperUserRelationships PaperUserRelationships) ;
	int updatePaperUserRelationships(int relationID, int filltimes, String paperLastFillDate);
	
	PaperUserRelationships findRelationShipsBypaperIdandUserip(int paperId, String userIP) ;
}
