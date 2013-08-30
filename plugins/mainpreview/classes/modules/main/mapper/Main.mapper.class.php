<?php
/*-------------------------------------------------------
*
*   LiveStreet Engine Social Networking
*   Copyright © 2008 Mzhelskiy Maxim
*
*--------------------------------------------------------
*
*   Official site: www.livestreet.ru
*   Contact e-mail: rus.engine@gmail.com
*
*   GNU General Public License, version 2:
*   http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
*
---------------------------------------------------------
*/

class PluginMainpreview_ModuleMain_MapperMain extends Mapper {

	public function GetTopics(&$iCount,$iCurrPage,$iPerPage) {
		$sql = "
							SELECT
								topic_id
							FROM
								".Config::Get('db.table.topic')."
							ORDER BY topic_id DESC
                            LIMIT ?d, ?d ";

		$aTopics=array();
		if ($aRows=$this->oDb->selectPage($iCount,$sql,($iCurrPage-1)*$iPerPage, $iPerPage)) {
			foreach ($aRows as $aTopic) {
				$aTopics[]=$aTopic['topic_id'];
			}
		}
		return $aTopics;
	}
}
?>