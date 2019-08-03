module.exports = [
  {
    name: 'Vanilla',
    suffix: '_vanilla'
  },
  {
    name: 'CUP',
    suffix: '_cup',
    woodland: {
      blufor: {
        B_Heli_Transport_01_camo_F: 'CUP_B_UH60S_USN',
        B_helicrew_F: 'CUP_B_USMC_Pilot',
        B_Helipilot_F: 'CUP_B_USMC_Pilot',
        B_medic_F: 'CUP_B_USMC_Medic',
        B_Pilot_F: 'CUP_B_USMC_Pilot',
        B_soldier_AAT_F: 'CUP_B_USMC_Soldier_LAT',
        B_soldier_AR_F: 'CUP_B_USMC_Soldier_AR',
        B_soldier_AT_F: 'CUP_B_USMC_Soldier_AT',
        B_Soldier_SL_F: 'CUP_B_USMC_Soldier_SL',
        B_Soldier_TL_F: 'CUP_B_USMC_Soldier_TL'
      },
      redfor: {
        '"OPF_F" >> "Infantry" >> "OIA_InfSquad"': '"CUP_O_RU" >> "Infantry" >> "CUP_O_RU_InfSquad_VDV_EMR"',
        O_APC_Tracked_02_cannon_F: 'CUP_O_BTR90_RU',
        O_Heli_Light_02_unarmed_F: 'CUP_O_Mi8_RU',
        O_medic_F: 'CUP_O_RU_Medic',
        O_MRAP_02_F: 'CUP_O_UAZ_MG_RU',
        O_MRAP_02_hmg_F: 'CUP_O_GAZ_Vodnik_PK_RU',
        O_Soldier_AR_F: 'CUP_O_RU_Soldier_AR',
        O_Soldier_F: 'CUP_O_RU_Soldier',
        O_Soldier_LAT_F: 'CUP_O_RU_Soldier_LAT',
        O_Soldier_SL_F: 'CUP_O_RU_Soldier_SL',
        O_Soldier_TL_F: 'CUP_O_RU_Soldier_TL'
      }
    }
  },
  {
    name: 'GM + CUP',
    suffix: '_gm_cup',
    woodland: {
      blufor: {
        B_Heli_Transport_01_camo_F: 'CUP_B_UH1D_GER_KSK',
        B_helicrew_F: 'gm_ge_army_crew_mp2a1_80_oli',
        B_Helipilot_F: 'gm_ge_army_crew_mp2a1_80_oli',
        B_medic_F: 'gm_ge_army_medic_g3a3_80_ols',
        B_Pilot_F: 'gm_ge_army_crew_mp2a1_80_oli',
        B_soldier_AAT_F: 'gm_ge_army_antitank_assistant_g3a3_pzf44_80_ols',
        B_soldier_AR_F: 'gm_ge_army_machinegunner_mg3_80_ols',
        B_soldier_AT_F: 'gm_ge_army_antitank_g3a3_pzf44_80_ols',
        B_Soldier_SL_F: 'gm_ge_army_squadleader_g3a3_p2a1_80_ols',
        B_Soldier_TL_F: 'gm_ge_army_squadleader_g3a3_p2a1_80_ols'
      },
      redfor: {
        '"OPF_F" >> "Infantry" >> "OIA_InfSquad"': '"gm_gc_army" >> "gm_infantry" >> "gm_gc_army_infantry_squad_str"',
        O_APC_Tracked_02_cannon_F: 'gm_gc_army_btr60pb',
        O_Heli_Light_02_unarmed_F: 'CUP_O_Mi8_RU',
        O_medic_F: 'gm_gc_army_medic_mpiak74n_80_str',
        O_MRAP_02_F: 'gm_gc_army_p601',
        O_MRAP_02_hmg_F: 'gm_gc_army_brdm2',
        O_Soldier_AR_F: 'gm_gc_army_machinegunner_lmgrpk_80_str',
        O_Soldier_F: 'gm_gc_army_rifleman_mpiak74n_80_str',
        O_Soldier_LAT_F: 'gm_gc_army_antitank_mpiak74n_rpg7_80_str',
        O_Soldier_SL_F: 'gm_gc_army_squadleader_mpiak74n_80_str',
        O_Soldier_TL_F: 'gm_gc_army_squadleader_mpiak74n_80_str'
      }
    }
  },
  {
    name: 'LDF',
    suffix: '_ldf',
    woodland: {
      blufor: {
        B_Heli_Transport_01_camo_F: 'I_E_Heli_light_03_unarmed_F',
        B_helicrew_F: 'I_E_Helicrew_F',
        B_Helipilot_F: 'I_E_Helipilot_F',
        B_medic_F: 'I_E_Medic_F',
        B_Pilot_F: 'I_E_Helipilot_F',
        B_soldier_AAT_F: 'I_E_Soldier_LAT_F',
        B_soldier_AR_F: 'I_E_Soldier_AR_F',
        B_soldier_AT_F: 'I_E_Soldier_LAT_F',
        B_Soldier_SL_F: 'I_E_Soldier_SL_F',
        B_Soldier_TL_F: 'I_E_Soldier_TL_F'
      },
      redfor: {
        '"OPF_F" >> "Infantry" >> "OIA_InfSquad"': '"OPF_R_F" >> "SpecOps" >> "O_R_InfSquad"',
        O_APC_Tracked_02_cannon_F: 'O_APC_Tracked_02_cannon_F',
        O_Heli_Light_02_unarmed_F: 'O_Heli_Light_02_unarmed_F',
        O_medic_F: 'O_R_medic_F',
        O_MRAP_02_F: 'O_MRAP_02_F',
        O_MRAP_02_hmg_F: 'O_MRAP_02_hmg_F',
        O_Soldier_AR_F: 'O_R_Soldier_AR_F',
        O_Soldier_F: 'O_R_Soldier_GL_F',
        O_Soldier_LAT_F: 'O_R_Soldier_LAT_F',
        O_Soldier_SL_F: 'O_R_Soldier_TL_F',
        O_Soldier_TL_F: 'O_R_Soldier_TL_F'
      }
    }
  },
  {
    name: 'SFP + CUP',
    suffix: '_sfp_cup',
    woodland: {
      blufor: {
        B_Heli_Transport_01_camo_F: 'CUP_B_UH60M_FFV_US',
        B_helicrew_F: 'sfp_m90w_helipilot',
        B_Helipilot_F: 'sfp_m90w_helipilot',
        B_medic_F: 'sfp_m90w_medic',
        B_Pilot_F: 'sfp_m90w_helipilot',
        B_soldier_AAT_F: 'sfp_m90w_at_loader_grg86',
        B_soldier_AR_F: 'sfp_m90w_automaticrifleman_ksp90',
        B_soldier_AT_F: 'sfp_m90w_at_specialist_grg86',
        B_Soldier_SL_F: 'sfp_m90w_squadleader',
        B_Soldier_TL_F: 'sfp_m90w_teamleader'
      },
      redfor: {
        '"OPF_F" >> "Infantry" >> "OIA_InfSquad"': '"CUP_O_RU" >> "Infantry" >> "CUP_O_RU_InfSquad_VDV_EMR"',
        O_APC_Tracked_02_cannon_F: 'CUP_O_BTR90_RU',
        O_Heli_Light_02_unarmed_F: 'CUP_O_Mi8_RU',
        O_medic_F: 'CUP_O_RU_Medic',
        O_MRAP_02_F: 'CUP_O_UAZ_MG_RU',
        O_MRAP_02_hmg_F: 'CUP_O_GAZ_Vodnik_PK_RU',
        O_Soldier_AR_F: 'CUP_O_RU_Soldier_AR',
        O_Soldier_F: 'CUP_O_RU_Soldier',
        O_Soldier_LAT_F: 'CUP_O_RU_Soldier_LAT',
        O_Soldier_SL_F: 'CUP_O_RU_Soldier_SL',
        O_Soldier_TL_F: 'CUP_O_RU_Soldier_TL'
      }
    }
  },
  {
    name: 'Unsung',
    suffix: '_unsung',
    woodland: {
      blufor: {
        B_Heli_Transport_01_camo_F: 'uns_UH1H_m60_light',
        B_helicrew_F: 'uns_pilot6',
        B_Helipilot_F: 'uns_pilot5',
        B_medic_F: 'uns_US_25ID_MED',
        B_Pilot_F: 'uns_pilot5',
        B_soldier_AAT_F: 'uns_US_25ID_AT',
        B_soldier_AR_F: 'uns_US_25ID_HMG',
        B_soldier_AT_F: 'uns_US_25ID_AT',
        B_Soldier_SL_F: 'uns_US_25ID_SL',
        B_Soldier_TL_F: 'uns_US_25ID_RTO'
      },
      redfor: {
        '"OPF_F" >> "Infantry" >> "OIA_InfSquad"': '"UNSUNG_E_NVA" >> "NVA68Infantry" >> "NVA_68riflesquadone"',
        O_APC_Tracked_02_cannon_F: 'uns_Type55_M40',
        O_Heli_Light_02_unarmed_F: 'uns_Mi8T_VPAF',
        O_medic_F: 'uns_men_NVA_68_MED',
        O_MRAP_02_F: 'uns_Type55_LMG',
        O_MRAP_02_hmg_F: 'uns_Type55_twinMG',
        O_Soldier_AR_F: 'uns_men_NVA_68_HMG',
        O_Soldier_F: 'uns_men_NVA_68_AS4',
        O_Soldier_LAT_F: 'uns_men_NVA_68_AT2',
        O_Soldier_SL_F: 'uns_men_NVA_68_off',
        O_Soldier_TL_F: 'uns_men_NVA_68_RTO'
      }
    }
  }
]
