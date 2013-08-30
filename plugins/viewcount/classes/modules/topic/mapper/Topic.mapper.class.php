<?php
/*-------------------------------------------------------
 *
 *   Copyright © 2011 kpoxas
 *
 *--------------------------------------------------------
 *
 *   Official site: www.tetra-studio.com.ua
 *   Contact e-mail: tetra@tetra-studio.com.ua
 *
 *   GNU General Public License, version 2:
 *   http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
 *
 ---------------------------------------------------------
 */

class PluginViewcount_ModuleTopic_MapperTopic extends PluginViewcount_Inherit_ModuleTopic_MapperTopic {
		
	public function increaseTopicCountRead($sTopicId) {
		$sql = "UPDATE ".Config::Get('db.table.topic')." 
			SET 
				topic_count_read=topic_count_read+1
			WHERE
				topic_id = ?
		";			
		if ($this->oDb->query($sql,$sTopicId)) {
			return true;
		}		
		return false;
	}
	
	public function GetTopicsCountReadByArrayId($aArrayId) {
		if (!is_array($aArrayId) or count($aArrayId)==0) {
			return array();
		}
				
		$sql = "SELECT 
					topic_id AS ARRAY_KEY, topic_count_read				 
				FROM 
					".Config::Get('db.table.topic')."					
				WHERE 
					topic_id IN(?a) 									
				ORDER BY FIELD(topic_id,?a) ";		
		if ($aRows=$this->oDb->selectCol($sql,$aArrayId,$aArrayId)) {
			return $aRows;
		}		
		return array();
	}
	
}
?>