--[[
Title: Hooked On Ogrynics
Author: Wobin
Date: 04/03/2023
Repository: https://github.com/Wobin/HookedOnOgrynics
]]--

local mod = get_mod("Hooked On Ogrynics")
local UIWidget = require("scripts/managers/ui/ui_widget")
local MissionTemplates = require("scripts/settings/mission/mission_templates")
local UIRenderer = require("scripts/managers/ui/ui_renderer")

local lookup = {
  ["loc_mission_board_main_objective_propaganda_description"] = "Stop_Noisy",
  ["loc_mission_board_main_objective_complex_description"] = "Send_Message",
  ["loc_mission_board_main_objective_cargo_description"] = "Clear_Train_Station",
  ["loc_mission_board_main_objective_cartel_description"] = "Hack_Heretic",
  ["loc_mission_board_main_objective_rails_description"] = "Grab_Ammo",
  ["loc_mission_board_main_objective_darkforge_description"] = "Fix_Burny",
  ["loc_mission_board_main_objective_strain_description"] = "Smash_Stinky",
  ["loc_mission_board_main_objective_resurgence_description"] = "Clear_Posh_Station",
  ["loc_mission_board_main_objective_scavenge_description"] = "Steal_Stinky",
  ["loc_mission_board_main_objective_cooling_description"] = "Push_Freezy",
  ["loc_mission_board_main_objective_habblock_description"] = "Scan_Stinky",
  ["loc_mission_board_main_objective_trainstation_description"] = "Kill_Station_Boss",
  ["loc_mission_board_main_objective_enforcer_description"] = "Kill_Enforcer_Boss",
  ["loc_mission_board_main_objective_waterstockpile_description"] = "Clean_Splashy"  
  }
mod:hook_safe(CLASS.MissionBoardView, "_set_selected_mission", function(self, mission, move)
    local mission_template = MissionTemplates[mission.map]
    local ogryn_widget = self._widgets_by_name.ogryn_translation    
    local ogryn_name = lookup[mission_template.mission_description]
    if ogryn_name == nil then
      ogryn_name = "confused_ogryn_noises"
    end
    ogryn_widget.dirty = true
    ogryn_widget.content.text = "\"" ..  mod:localize(ogryn_name) .. "\""
    
		local text_width, text_height = UIRenderer.text_size(self:_begin_render_offscreen(), ogryn_widget.content.text, ogryn_widget.style.text.font_type, ogryn_widget.style.text.font_size)
    ogryn_widget.style.frame.size = { text_width + 15, text_height + 12}    
		ogryn_widget.style.background.size = { text_width + 15, text_height + 12}		    
  end)

mod:hook_safe(CLASS.MissionBoardView, "_set_selected_quickplay", function(self, move)
     local ogryn_widget = self._widgets_by_name.ogryn_translation
     ogryn_widget.dirty = true
     ogryn_widget.content.text = "\"" .. mod:localize("Emprah_Picks").. "\""
end)

mod:hook_require("scripts/ui/views/mission_board_view/mission_board_view_definitions", function(MissionBoardViewDefinitions)      
    if not MissionBoardViewDefinitions.ogryn_translation_template then      
      MissionBoardViewDefinitions.widget_definitions.ogryn_translation = UIWidget.create_definition({
          {
            value_id = "text",
            style_id = "text",
            pass_type = "text",
            scenegraph_id = "ogryn_translation",
            value = "ogryn translations",
            style = {
                scale_to_material = true,
                text_horizontal_alignment = "left",
                font_size = 24,
                text_vertical_alignment = "top",
                drop_shadow = true,
                font_type = "proxima_nova_bold",
                default_color = Color.citadel_macragge_blue(255, true),
                text_color = Color.white_smoke  (255, true),
                hover_color = Color.terminal_text_header_selected(255, true),
                disabled_color = Color.ui_grey_light(255, true),
                offset = {
                  5,
                  0,
                  25
                },
                size = {
                 560,
                 30
                }
              },                        
            },
          {
            style_id = "frame",
            scenegraph_id = "ogryn_translation",
            pass_type = "texture",
            value = "content/ui/materials/frames/frame_tile_2px",       
            style = {              
              color = Color.terminal_frame(nil, true),
              offset = {
                0,
                0,
                2
              },               
            },
          },
          {
            style_id = "background",
            scenegraph_id = "ogryn_translation",
            pass_type = "texture",
            value = "content/ui/materials/backgrounds/default_square",
            style = {
              scale_to_material = true,
              color = Color.terminal_background_dark(192, true)
              }
          }},"ogryn_translation")
    end
    if not MissionBoardViewDefinitions.scenegraph_definition.ogryn_translation then
        MissionBoardViewDefinitions.scenegraph_definition.ogryn_translation = {
          vertical_alignment = "top",
          parent = "detail_location",
          horizontal_alignment = "left",
          size = {
                    560,
                    30
                  },
                  position = {
                    15,
                     5,
                    10
                  }
        }
      end
      
    end)