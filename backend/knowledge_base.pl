/*
   PC Build Advisor knowledge base (manufacturer-sourced compatibility catalog)
   Units: millimeters, watts, gigabytes. Source pages were accessed 2026-11-21.
   Catalog entries are retained only where key specifications are verified.
   CPU compatibility in this advisor uses matching socket as its criterion.
*/

:- encoding(utf8).

% These catalog facts are grouped by component, so predicate clauses recur
% across the file. Mark those predicates as intentionally discontiguous.
:- discontiguous case_cooler_clearance_mm/2.
:- discontiguous case_form_factor_support/2.
:- discontiguous case_gpu_clearance_mm/2.
:- discontiguous case_radiator_support/3.
:- discontiguous case_radiator_support_known/1.
:- discontiguous component/4.
:- discontiguous cooler_height_mm/2.
:- discontiguous cooler_radiator_dimensions_mm/4.
:- discontiguous cooler_radiator_size_mm/2.
:- discontiguous cooler_socket_support/2.
:- discontiguous cooler_type/2.
:- discontiguous cpu_series/2.
:- discontiguous cpu_socket/2.
:- discontiguous cpu_tdp/2.
:- discontiguous gpu_dimensions_mm/4.
:- discontiguous gpu_power_connector/2.
:- discontiguous gpu_power_connector_count/3.
:- discontiguous gpu_power_for_estimate/2.
:- discontiguous memory_profile/2.
:- discontiguous memory_timing_cl/2.
:- discontiguous motherboard_form_factor/2.
:- discontiguous motherboard_max_memory_gb/2.
:- discontiguous motherboard_memory/2.
:- discontiguous motherboard_socket/2.
:- discontiguous motherboard_supported_cpu_series/2.
:- discontiguous psu_form_factor/2.
:- discontiguous psu_length_mm/2.

% component(Id, Category, DisplayName, Manufacturer)
component(ryzen_5_7600, cpu, 'AMD Ryzen 5 7600', amd).
component(ryzen_5_5600, cpu, 'AMD Ryzen 5 5600', amd).
component(msi_pro_b650s_wifi, motherboard, 'MSI PRO B650-S WIFI', msi).
component(msi_b550m_pro_vdh_wifi, motherboard, 'MSI B550M PRO-VDH WIFI', msi).
component(msi_mag_forge_112r, case, 'MSI MAG FORGE 112R', msi).

% ------------------------- CPU catalog -------------------------
% 10 AMD + 10 Intel desktop models. Exact socket/series/TDP facts are recorded
% only for models individually verified below; other rows stay unknown until
% model-specific manufacturer specifications are checked.
component(amd_ryzen_5_9600x, cpu, 'AMD Ryzen 5 9600X', amd).
component(amd_ryzen_7_9700x, cpu, 'AMD Ryzen 7 9700X', amd).
component(amd_ryzen_9_9900x, cpu, 'AMD Ryzen 9 9900X', amd).
component(amd_ryzen_9_9950x, cpu, 'AMD Ryzen 9 9950X', amd).
component(amd_ryzen_5_7600x, cpu, 'AMD Ryzen 5 7600X', amd).
component(amd_ryzen_7_7800x3d, cpu, 'AMD Ryzen 7 7800X3D', amd).
component(amd_ryzen_9_7950x, cpu, 'AMD Ryzen 9 7950X', amd).
component(amd_ryzen_7_7700, cpu, 'AMD Ryzen 7 7700', amd).
component(amd_ryzen_5_5600x, cpu, 'AMD Ryzen 5 5600X', amd).
component(amd_ryzen_7_5800x3d, cpu, 'AMD Ryzen 7 5800X3D', amd).
component(amd_ryzen_3_4100, cpu, 'AMD Ryzen 3 4100', amd).
component(amd_ryzen_3_3100, cpu, 'AMD Ryzen 3 3100', amd).
component(intel_core_i5_14600k, cpu, 'Intel Core i5-14600K', intel).
component(intel_core_i5_14600kf, cpu, 'Intel Core i5-14600KF', intel).
component(intel_core_i7_14700k, cpu, 'Intel Core i7-14700K', intel).
component(intel_core_i7_14700kf, cpu, 'Intel Core i7-14700KF', intel).
component(intel_core_i9_14900k, cpu, 'Intel Core i9-14900K', intel).
component(intel_core_i9_14900kf, cpu, 'Intel Core i9-14900KF', intel).
component(intel_core_i5_13600k, cpu, 'Intel Core i5-13600K', intel).
component(intel_core_i7_13700k, cpu, 'Intel Core i7-13700K', intel).
component(intel_core_i5_12600k, cpu, 'Intel Core i5-12600K', intel).
component(intel_core_i7_12700k, cpu, 'Intel Core i7-12700K', intel).
component(intel_core_i3_14100, cpu, 'Intel Core i3-14100', intel).
component(intel_core_i3_12100, cpu, 'Intel Core i3-12100', intel).

cpu_socket(amd_ryzen_5_9600x, am5). cpu_tdp(amd_ryzen_5_9600x, 65). cpu_series(amd_ryzen_5_9600x, ryzen_9000).
cpu_socket(amd_ryzen_7_9700x, am5). cpu_tdp(amd_ryzen_7_9700x, 65). cpu_series(amd_ryzen_7_9700x, ryzen_9000).
cpu_socket(amd_ryzen_9_9900x, am5). cpu_series(amd_ryzen_9_9900x, ryzen_9000).
cpu_socket(amd_ryzen_9_9950x, am5). cpu_series(amd_ryzen_9_9950x, ryzen_9000).
cpu_socket(amd_ryzen_5_7600x, am5). cpu_series(amd_ryzen_5_7600x, ryzen_7000).
cpu_socket(amd_ryzen_7_7800x3d, am5). cpu_series(amd_ryzen_7_7800x3d, ryzen_7000).
cpu_socket(amd_ryzen_9_7950x, am5). cpu_series(amd_ryzen_9_7950x, ryzen_7000).
cpu_socket(amd_ryzen_7_7700, am5). cpu_series(amd_ryzen_7_7700, ryzen_7000).
cpu_socket(amd_ryzen_5_5600x, am4). cpu_series(amd_ryzen_5_5600x, ryzen_5000).
cpu_socket(amd_ryzen_7_5800x3d, am4). cpu_series(amd_ryzen_7_5800x3d, ryzen_5000).
cpu_socket(amd_ryzen_3_4100, am4). cpu_tdp(amd_ryzen_3_4100, 65). cpu_series(amd_ryzen_3_4100, ryzen_4000).
cpu_socket(amd_ryzen_3_3100, am4). cpu_series(amd_ryzen_3_3100, ryzen_3000).
cpu_socket(intel_core_i5_14600k, lga1700). cpu_tdp(intel_core_i5_14600k, 125). cpu_series(intel_core_i5_14600k, intel_14th).
cpu_socket(intel_core_i5_14600kf, lga1700). cpu_series(intel_core_i5_14600kf, intel_14th).
cpu_socket(intel_core_i7_14700k, lga1700). cpu_series(intel_core_i7_14700k, intel_14th).
cpu_socket(intel_core_i7_14700kf, lga1700). cpu_series(intel_core_i7_14700kf, intel_14th).
cpu_socket(intel_core_i9_14900k, lga1700). cpu_series(intel_core_i9_14900k, intel_14th).
cpu_socket(intel_core_i9_14900kf, lga1700). cpu_series(intel_core_i9_14900kf, intel_14th).
cpu_socket(intel_core_i5_13600k, lga1700). cpu_series(intel_core_i5_13600k, intel_13th).
cpu_socket(intel_core_i7_13700k, lga1700). cpu_series(intel_core_i7_13700k, intel_13th).
cpu_socket(intel_core_i5_12600k, lga1700). cpu_series(intel_core_i5_12600k, intel_12th).
cpu_socket(intel_core_i7_12700k, lga1700). cpu_series(intel_core_i7_12700k, intel_12th).
cpu_socket(intel_core_i3_14100, lga1700). cpu_series(intel_core_i3_14100, intel_14th).
cpu_socket(intel_core_i3_12100, lga1700). cpu_series(intel_core_i3_12100, intel_12th).

% UI tier labels let the advisor offer each consumer segment as a group.
processor_tier(intel_core_i3_14100, i3). processor_tier(intel_core_i3_12100, i3).
processor_tier(intel_core_i5_14600k, i5). processor_tier(intel_core_i5_14600kf, i5).
processor_tier(intel_core_i5_13600k, i5). processor_tier(intel_core_i5_12600k, i5).
processor_tier(intel_core_i7_14700k, i7). processor_tier(intel_core_i7_14700kf, i7).
processor_tier(intel_core_i7_13700k, i7). processor_tier(intel_core_i7_12700k, i7).
processor_tier(intel_core_i9_14900k, i9). processor_tier(intel_core_i9_14900kf, i9).
processor_tier(amd_ryzen_3_4100, ryzen3). processor_tier(amd_ryzen_3_3100, ryzen3).
processor_tier(ryzen_5_7600, ryzen5). processor_tier(ryzen_5_5600, ryzen5).
processor_tier(amd_ryzen_5_9600x, ryzen5). processor_tier(amd_ryzen_5_7600x, ryzen5).
processor_tier(amd_ryzen_5_5600x, ryzen5).
processor_tier(amd_ryzen_7_9700x, ryzen7). processor_tier(amd_ryzen_7_7800x3d, ryzen7).
processor_tier(amd_ryzen_7_7700, ryzen7). processor_tier(amd_ryzen_7_5800x3d, ryzen7).
processor_tier(amd_ryzen_9_9900x, ryzen9). processor_tier(amd_ryzen_9_9950x, ryzen9).
processor_tier(amd_ryzen_9_7950x, ryzen9).

% Platform map filters boards by socket and memory generation.
motherboard_platform(am4, ddr4).
motherboard_platform(am5, ddr5).
motherboard_platform(lga1700, ddr4).
motherboard_platform(lga1700, ddr5).
board_platform(Board, Socket, MemoryType) :-
    motherboard_socket(Board, Socket), motherboard_memory(Board, MemoryType).
platform_boards_for_cpu(Cpu, Board) :-
    cpu_socket(Cpu, Socket), board_platform(Board, Socket, _).

% ---------------------- Motherboard catalog ---------------------
% Intel boards use LGA1700. Check each board's DDR generation separately.
component(msi_mag_x870_tomahawk, motherboard, 'MSI MAG X870 TOMAHAWK WIFI', msi).
component(msi_x870e_carbon, motherboard, 'MSI MPG X870E CARBON WIFI', msi).
component(msi_b850_gaming_plus, motherboard, 'MSI B850 GAMING PLUS WIFI', msi).
component(msi_b650_tomahawk, motherboard, 'MSI MAG B650 TOMAHAWK WIFI', msi).
component(msi_b550_tomahawk, motherboard, 'MSI MAG B550 TOMAHAWK', msi).
component(msi_z790_tomahawk_wifi_ddr4, motherboard, 'MSI MAG Z790 TOMAHAWK WIFI DDR4', msi).
component(msi_z790_gaming_plus, motherboard, 'MSI Z790 GAMING PLUS WIFI', msi).
component(msi_z790_pro_p, motherboard, 'MSI PRO Z790-P WIFI', msi).
component(msi_b760_gaming_plus, motherboard, 'MSI B760 GAMING PLUS WIFI', msi).
component(msi_pro_b760m_a_wifi_ddr4, motherboard, 'MSI PRO B760M-A WIFI DDR4', msi).
component(msi_b660m_mortar, motherboard, 'MSI MAG B660M MORTAR WIFI', msi).
motherboard_socket(msi_mag_x870_tomahawk, am5). motherboard_form_factor(msi_mag_x870_tomahawk, atx). motherboard_memory(msi_mag_x870_tomahawk, ddr5).
motherboard_socket(msi_x870e_carbon, am5). motherboard_form_factor(msi_x870e_carbon, atx). motherboard_memory(msi_x870e_carbon, ddr5).
motherboard_socket(msi_b850_gaming_plus, am5). motherboard_form_factor(msi_b850_gaming_plus, atx). motherboard_memory(msi_b850_gaming_plus, ddr5).
motherboard_socket(msi_b650_tomahawk, am5). motherboard_form_factor(msi_b650_tomahawk, atx). motherboard_memory(msi_b650_tomahawk, ddr5).
motherboard_socket(msi_b550_tomahawk, am4). motherboard_form_factor(msi_b550_tomahawk, atx). motherboard_memory(msi_b550_tomahawk, ddr4).
motherboard_socket(msi_z790_tomahawk_wifi_ddr4, lga1700). motherboard_form_factor(msi_z790_tomahawk_wifi_ddr4, atx). motherboard_memory(msi_z790_tomahawk_wifi_ddr4, ddr4).
motherboard_socket(msi_z790_gaming_plus, lga1700). motherboard_form_factor(msi_z790_gaming_plus, atx). motherboard_memory(msi_z790_gaming_plus, ddr5).
motherboard_socket(msi_z790_pro_p, lga1700). motherboard_form_factor(msi_z790_pro_p, atx). motherboard_memory(msi_z790_pro_p, ddr5).
motherboard_socket(msi_b760_gaming_plus, lga1700). motherboard_form_factor(msi_b760_gaming_plus, atx). motherboard_memory(msi_b760_gaming_plus, ddr5).
motherboard_socket(msi_pro_b760m_a_wifi_ddr4, lga1700). motherboard_form_factor(msi_pro_b760m_a_wifi_ddr4, micro_atx). motherboard_memory(msi_pro_b760m_a_wifi_ddr4, ddr4).
motherboard_socket(msi_b660m_mortar, lga1700). motherboard_form_factor(msi_b660m_mortar, micro_atx). motherboard_memory(msi_b660m_mortar, ddr5).

% motherboard_storage(Board, SataPortCount, NvmeM2Sizes, SataM2Sizes).
% Each size list covers the slots that support that protocol. An empty list
% means the board has no documented M.2 slot for that protocol.
motherboard_storage(msi_mag_x870_tomahawk, 4, [2260, 2280, 22110], []).
motherboard_storage(msi_x870e_carbon, 4, [2260, 2280, 22110], []).
motherboard_storage(msi_b850_gaming_plus, 4, [2260, 2280, 22110], []).
motherboard_storage(msi_b650_tomahawk, 6, [2260, 2280, 22110], []).
motherboard_storage(msi_b550_tomahawk, 6, [2242, 2260, 2280, 22110], [2242, 2260, 2280, 22110]).
motherboard_storage(msi_z790_tomahawk_wifi_ddr4, 7, [2242, 2260, 2280, 22110], [2242, 2260, 2280]).
motherboard_storage(msi_z790_gaming_plus, 6, [2242, 2260, 2280, 22110], [2242, 2260, 2280]).
motherboard_storage(msi_z790_pro_p, 6, [2242, 2260, 2280, 22110], [2242, 2260, 2280]).
motherboard_storage(msi_b760_gaming_plus, 4, [2242, 2260, 2280, 22110], [2242, 2260, 2280]).
motherboard_storage(msi_pro_b760m_a_wifi_ddr4, 4, [2242, 2260, 2280], [2242, 2260, 2280]).
motherboard_storage(msi_b660m_mortar, 6, [2242, 2260, 2280], [2242, 2260, 2280]).
motherboard_storage(msi_pro_b650s_wifi, 4, [2260, 2280, 22110], []).
motherboard_storage(msi_b550m_pro_vdh_wifi, 4, [2242, 2260, 2280], [2242, 2260, 2280]).

% -------------------------- Storage catalog --------------------
component(samsung_9100_pro_2tb, storage, 'Samsung 9100 PRO 2 TB (MZ-VAP2T0B)', samsung).
component(samsung_990_pro_2tb, storage, 'Samsung 990 PRO 2 TB (MZ-V9P2T0B)', samsung).
component(samsung_970_evo_plus_1tb, storage, 'Samsung 970 EVO Plus 1 TB (MZ-V7S1T0BW)', samsung).
component(wd_black_sn850x_2tb, storage, 'WD_BLACK SN850X 2 TB (WDS200T2X0E)', western_digital).
component(kingston_nv3_1tb, storage, 'Kingston NV3 1 TB (SNV3S/1000G)', kingston).
component(wd_blue_sa510_m2_1tb, storage, 'WD Blue SA510 M.2 1 TB (WDS100T3B0B)', western_digital).
component(samsung_870_evo_1tb, storage, 'Samsung 870 EVO 1 TB (MZ-77E1T0B)', samsung).
component(samsung_870_qvo_2tb, storage, 'Samsung 870 QVO 2 TB (MZ-77Q2T0B)', samsung).
component(crucial_bx500_1tb, storage, 'Crucial BX500 1 TB (CT1000BX500SSD1)', crucial).
component(seagate_barracuda_2tb, storage, 'Seagate BarraCuda 2 TB (ST2000DM008)', seagate).

% storage_drive(Id, CapacityGB, FormFactor, Interface).
% nvme(Generation, Lanes) describes the drive's advertised PCIe link.
storage_drive(samsung_9100_pro_2tb, 2000, m2(2280), nvme(5, 4)).
storage_drive(samsung_990_pro_2tb, 2000, m2(2280), nvme(4, 4)).
storage_drive(samsung_970_evo_plus_1tb, 1000, m2(2280), nvme(3, 4)).
storage_drive(wd_black_sn850x_2tb, 2000, m2(2280), nvme(4, 4)).
storage_drive(kingston_nv3_1tb, 1000, m2(2280), nvme(4, 4)).
storage_drive(wd_blue_sa510_m2_1tb, 1000, m2(2280), sata).
storage_drive(samsung_870_evo_1tb, 1000, inch_2_5, sata).
storage_drive(samsung_870_qvo_2tb, 2000, inch_2_5, sata).
storage_drive(crucial_bx500_1tb, 1000, inch_2_5, sata).
storage_drive(seagate_barracuda_2tb, 2000, inch_3_5, sata).

% --------------------------- RAM catalog ------------------------
% DDR generation is the board-memory compatibility criterion. Capacity,
% speed, timing, and profile remain descriptive catalog information.
component(corsair_vengeance_ddr5_32, memory, 'Corsair Vengeance DDR5 32GB (2x16GB), 6000 CL30, CMK32GX5M2B6000Z30', corsair).
component(corsair_vengeance_ddr5_64, memory, 'Corsair Vengeance DDR5 64GB (2x32GB), 6000 CL40, CMK64GX5M2D6000Z40', corsair).
component(corsair_dominator_ddr5_32, memory, 'Corsair Dominator Titanium DDR5 32GB (2x16GB), 6000 CL30, CMP32GX5M2B6000Z30', corsair).
component(crucial_pro_ddr5_32, memory, 'Crucial Pro DDR5 32GB (2x16GB), 5600 CL46, CP2K16G56C46U5', crucial).
component(crucial_pro_ddr5_64, memory, 'Crucial Pro DDR5 64GB (2x32GB), 5600 CL46, CP2K32G56C46U5', crucial).
component(gskill_flare_x5_ddr5_32, memory, 'G.Skill Flare X5 DDR5 32GB (2x16GB), 6000 CL36, F5-6000J3648D16GX2-FX5', gskill).
component(gskill_trident_z5_ddr5_32, memory, 'G.Skill Trident Z5 DDR5 32GB (2x16GB), 6000 CL36, F5-6000J3636F16GX2-TZ5K', gskill).
component(corsair_vengeance_ddr4_32, memory, 'Corsair Vengeance LPX DDR4 32GB (2x16GB), 3200 CL16, CMK32GX4M2E3200C16', corsair).
component(crucial_pro_ddr4_32, memory, 'Crucial Pro DDR4 32GB (2x16GB), 3200 CL22, CP2K16G4DFRA32A', crucial).
component(gskill_ripjaws_v_ddr4_32, memory, 'G.Skill Ripjaws V DDR4 32GB (2x16GB), 3200 CL16, F4-3200C16D-32GVK', gskill).
memory(corsair_vengeance_ddr5_32, ddr5, 32, 6000).
memory(corsair_vengeance_ddr5_64, ddr5, 64, 6000).
memory(corsair_dominator_ddr5_32, ddr5, 32, 6000).
memory(crucial_pro_ddr5_32, ddr5, 32, 5600).
memory(crucial_pro_ddr5_64, ddr5, 64, 5600).
memory(gskill_flare_x5_ddr5_32, ddr5, 32, 6000).
memory(gskill_trident_z5_ddr5_32, ddr5, 32, 6000).
memory(corsair_vengeance_ddr4_32, ddr4, 32, 3200).
memory(crucial_pro_ddr4_32, ddr4, 32, 3200).
memory(gskill_ripjaws_v_ddr4_32, ddr4, 32, 3200).
memory_timing_cl(corsair_vengeance_ddr5_32, 30). memory_profile(corsair_vengeance_ddr5_32, amd_expo_intel_xmp).
memory_timing_cl(corsair_vengeance_ddr5_64, 40). memory_profile(corsair_vengeance_ddr5_64, amd_expo_intel_xmp).
memory_timing_cl(corsair_dominator_ddr5_32, 30). memory_profile(corsair_dominator_ddr5_32, amd_expo_intel_xmp).
memory_timing_cl(crucial_pro_ddr5_32, 46). memory_profile(crucial_pro_ddr5_32, jedec).
memory_timing_cl(crucial_pro_ddr5_64, 46). memory_profile(crucial_pro_ddr5_64, jedec).
memory_timing_cl(gskill_flare_x5_ddr5_32, 36). memory_profile(gskill_flare_x5_ddr5_32, amd_expo_intel_xmp).
memory_timing_cl(gskill_trident_z5_ddr5_32, 36). memory_profile(gskill_trident_z5_ddr5_32, amd_expo_intel_xmp).
memory_timing_cl(corsair_vengeance_ddr4_32, 16). memory_profile(corsair_vengeance_ddr4_32, intel_xmp_2).
memory_timing_cl(crucial_pro_ddr4_32, 22). memory_profile(crucial_pro_ddr4_32, jedec).
memory_timing_cl(gskill_ripjaws_v_ddr4_32, 16). memory_profile(gskill_ripjaws_v_ddr4_32, intel_xmp_2).

% ---------------------------- GPU catalog -----------------------
component(msi_rtx_4060_ventus_2x, gpu, 'MSI GeForce RTX 4060 VENTUS 2X BLACK 8G', msi).
component(msi_rtx_4070_super_ventus, gpu, 'MSI GeForce RTX 4070 SUPER 12G VENTUS 2X OC', msi).
component(msi_rtx_4070_ti_super, gpu, 'MSI GeForce RTX 4070 Ti SUPER 16G VENTUS 2X OC', msi).
component(msi_rtx_4080_super, gpu, 'MSI GeForce RTX 4080 SUPER 16G VENTUS 3X OC', msi).
component(msi_rtx_4090_suprim, gpu, 'MSI GeForce RTX 4090 SUPRIM X 24G', msi).
component(msi_rtx_5070_ventus, gpu, 'MSI GeForce RTX 5070 12G VENTUS 2X OC', msi).
component(msi_rtx_5080_ventus, gpu, 'MSI GeForce RTX 5080 16G VENTUS 3X OC', msi).
component(msi_rx_7600_mech, gpu, 'MSI Radeon RX 7600 MECH 2X CLASSIC 8G OC', msi).
component(gigabyte_rx_7800xt_gaming, gpu, 'Gigabyte Radeon RX 7800 XT GAMING OC 16G', gigabyte).
component(msi_rx_7900xtx_gaming, gpu, 'MSI Radeon RX 7900 XTX GAMING TRIO CLASSIC 24G', msi).
% GPU power estimates are entered only when a product-specific source exists.
% MSI lists 115 W or 120 W; use the upper value for a conservative estimate.
gpu_power_for_estimate(msi_rtx_4060_ventus_2x, 120).
gpu_power_connector(msi_rtx_4060_ventus_2x, pcie_8pin).
gpu_dimensions_mm(msi_rtx_4060_ventus_2x, 199, 120, 41).
gpu_power_for_estimate(msi_rtx_4070_super_ventus, 220). gpu_power_connector(msi_rtx_4070_super_ventus, pcie_16pin).
gpu_dimensions_mm(msi_rtx_4070_super_ventus, 242, 125, 43).
gpu_power_for_estimate(msi_rtx_4070_ti_super, 285). gpu_power_connector(msi_rtx_4070_ti_super, pcie_16pin).
gpu_dimensions_mm(msi_rtx_4070_ti_super, 242, 125, 51).
gpu_power_for_estimate(msi_rtx_4080_super, 320). gpu_power_connector(msi_rtx_4080_super, pcie_16pin).
gpu_dimensions_mm(msi_rtx_4080_super, 322, 136, 62).
gpu_power_for_estimate(msi_rtx_4090_suprim, 480). gpu_power_connector(msi_rtx_4090_suprim, pcie_16pin).
gpu_dimensions_mm(msi_rtx_4090_suprim, 336, 142, 78).
gpu_power_for_estimate(msi_rtx_5070_ventus, 250). gpu_power_connector(msi_rtx_5070_ventus, pcie_16pin).
gpu_dimensions_mm(msi_rtx_5070_ventus, 236, 126, 50).
gpu_power_for_estimate(msi_rtx_5080_ventus, 360). gpu_power_connector(msi_rtx_5080_ventus, pcie_16pin).
gpu_dimensions_mm(msi_rtx_5080_ventus, 303, 121, 49).
gpu_power_for_estimate(msi_rx_7600_mech, 165). gpu_power_connector(msi_rx_7600_mech, pcie_8pin).
gpu_dimensions_mm(msi_rx_7600_mech, 235, 125, 47).
gpu_power_for_estimate(gigabyte_rx_7800xt_gaming, 263).
gpu_power_connector_count(gigabyte_rx_7800xt_gaming, pcie_8pin, 2).
gpu_dimensions_mm(gigabyte_rx_7800xt_gaming, 302, 130, 56).
gpu_power_for_estimate(msi_rx_7900xtx_gaming, 355).
gpu_power_connector_count(msi_rx_7900xtx_gaming, pcie_8pin, 3).
gpu_dimensions_mm(msi_rx_7900xtx_gaming, 325, 141, 56).

% ---------------------------- Case catalog ----------------------
component(corsair_4000d_airflow, case, 'Corsair 4000D Airflow', corsair).
component(corsair_5000d_airflow, case, 'Corsair 5000D Airflow', corsair).
component(corsair_7000d_airflow, case, 'Corsair 7000D Airflow', corsair).
component(nzxt_h5_flow, case, 'NZXT H5 Flow', nzxt).
component(nzxt_h7_flow, case, 'NZXT H7 Flow (2024)', nzxt).
component(fractal_pop_air, case, 'Fractal Design Pop Air', fractal_design).
component(fractal_meshify_2, case, 'Fractal Design Meshify 2', fractal_design).
component(lian_li_lancool_216, case, 'Lian Li LANCOOL 216', lian_li).
component(phanteks_nv5, case, 'Phanteks NV5', phanteks).
component(msi_mag_pano_100r, case, 'MSI MAG PANO 100R PZ', msi).
case_gpu_clearance_mm(corsair_4000d_airflow, 360). case_cooler_clearance_mm(corsair_4000d_airflow, 170).
case_gpu_clearance_mm(corsair_5000d_airflow, 420). case_cooler_clearance_mm(corsair_5000d_airflow, 170).
case_gpu_clearance_mm(corsair_7000d_airflow, 450). case_cooler_clearance_mm(corsair_7000d_airflow, 190).
case_form_factor_support(corsair_4000d_airflow, atx). case_form_factor_support(corsair_4000d_airflow, micro_atx). case_form_factor_support(corsair_4000d_airflow, mini_itx).
case_form_factor_support(corsair_5000d_airflow, atx). case_form_factor_support(corsair_5000d_airflow, micro_atx). case_form_factor_support(corsair_5000d_airflow, mini_itx).
case_form_factor_support(corsair_7000d_airflow, atx). case_form_factor_support(corsair_7000d_airflow, micro_atx). case_form_factor_support(corsair_7000d_airflow, mini_itx).
case_gpu_clearance_mm(nzxt_h5_flow, 410). case_cooler_clearance_mm(nzxt_h5_flow, 170).
case_form_factor_support(nzxt_h5_flow, eatx). case_form_factor_support(nzxt_h5_flow, atx). case_form_factor_support(nzxt_h5_flow, micro_atx). case_form_factor_support(nzxt_h5_flow, mini_itx).
case_gpu_clearance_mm(nzxt_h7_flow, 410). case_cooler_clearance_mm(nzxt_h7_flow, 185).
case_form_factor_support(nzxt_h7_flow, eatx). case_form_factor_support(nzxt_h7_flow, atx). case_form_factor_support(nzxt_h7_flow, micro_atx). case_form_factor_support(nzxt_h7_flow, mini_itx).
case_gpu_clearance_mm(fractal_pop_air, 405). case_cooler_clearance_mm(fractal_pop_air, 170).
case_form_factor_support(fractal_pop_air, atx). case_form_factor_support(fractal_pop_air, micro_atx). case_form_factor_support(fractal_pop_air, mini_itx).
case_gpu_clearance_mm(fractal_meshify_2, 470). case_cooler_clearance_mm(fractal_meshify_2, 185).
case_form_factor_support(fractal_meshify_2, eatx). case_form_factor_support(fractal_meshify_2, atx). case_form_factor_support(fractal_meshify_2, micro_atx). case_form_factor_support(fractal_meshify_2, mini_itx).
case_gpu_clearance_mm(lian_li_lancool_216, 392). case_cooler_clearance_mm(lian_li_lancool_216, 180.5).
case_form_factor_support(lian_li_lancool_216, eatx). case_form_factor_support(lian_li_lancool_216, atx). case_form_factor_support(lian_li_lancool_216, micro_atx). case_form_factor_support(lian_li_lancool_216, mini_itx).
case_gpu_clearance_mm(phanteks_nv5, 440). case_cooler_clearance_mm(phanteks_nv5, 180).
case_form_factor_support(phanteks_nv5, eatx). case_form_factor_support(phanteks_nv5, atx). case_form_factor_support(phanteks_nv5, micro_atx). case_form_factor_support(phanteks_nv5, mini_itx).
case_gpu_clearance_mm(msi_mag_pano_100r, 400). case_cooler_clearance_mm(msi_mag_pano_100r, 166).
case_form_factor_support(msi_mag_pano_100r, atx). case_form_factor_support(msi_mag_pano_100r, micro_atx). case_form_factor_support(msi_mag_pano_100r, mini_itx).

% ------------------------------ PSU catalog ---------------------
component(seasonic_focus_gx_750, psu, 'Seasonic FOCUS GX-750', seasonic).
component(seasonic_focus_gx_850, psu, 'Seasonic FOCUS GX-850', seasonic).
component(seasonic_focus_gx_1000, psu, 'Seasonic FOCUS GX-1000', seasonic).
component(seasonic_focus_gx_550, psu, 'Seasonic FOCUS GX-550', seasonic).
component(seasonic_focus_gx_650, psu, 'Seasonic FOCUS GX-650', seasonic).
component(corsair_rm750e, psu, 'Corsair RM750e', corsair).
component(corsair_rm850x, psu, 'Corsair RM850x', corsair).
component(corsair_rm1000x, psu, 'Corsair RM1000x', corsair).
component(be_quiet_pure_power_12m_750, psu, 'be quiet! Pure Power 12 M 750W', be_quiet).
component(be_quiet_pure_power_12m_850, psu, 'be quiet! Pure Power 12 M 850W', be_quiet).
component(msi_mpg_a850g_pcie5, psu, 'MSI MPG A850G PCIE5', msi).
component(msi_mpg_a1000g_pcie5, psu, 'MSI MPG A1000G PCIE5', msi).
component(corsair_sf750_sfx, psu, 'Corsair SF750 750W SFX', corsair).
component(coolermaster_v_sfx_gold_850, psu, 'Cooler Master V SFX Gold 850 ATX 3.1', cooler_master).
component(silverstone_sx1000r_platinum, psu, 'SilverStone SX1000R Platinum 1000W SFX-L', silverstone).
component(silverstone_sx1000_lpt, psu, 'SilverStone SX1000 Platinum (SST-SX1000-LPT) 1000W SFX-L', silverstone).
psu_wattage(seasonic_focus_gx_750, 750). psu_wattage(seasonic_focus_gx_850, 850). psu_wattage(seasonic_focus_gx_1000, 1000).
psu_wattage(seasonic_focus_gx_550, 550). psu_wattage(seasonic_focus_gx_650, 650).
psu_wattage(corsair_rm750e, 750). psu_wattage(corsair_rm850x, 850). psu_wattage(corsair_rm1000x, 1000).
psu_wattage(be_quiet_pure_power_12m_750, 750). psu_wattage(be_quiet_pure_power_12m_850, 850).
psu_wattage(msi_mpg_a850g_pcie5, 850). psu_wattage(msi_mpg_a1000g_pcie5, 1000).
psu_wattage(corsair_sf750_sfx, 750). psu_wattage(coolermaster_v_sfx_gold_850, 850).
psu_wattage(silverstone_sx1000r_platinum, 1000). psu_wattage(silverstone_sx1000_lpt, 1000).
psu_form_factor(seasonic_focus_gx_550, atx). psu_length_mm(seasonic_focus_gx_550, 140).
psu_form_factor(seasonic_focus_gx_650, atx). psu_length_mm(seasonic_focus_gx_650, 140).
psu_form_factor(seasonic_focus_gx_750, atx). psu_length_mm(seasonic_focus_gx_750, 140).
psu_form_factor(seasonic_focus_gx_850, atx). psu_length_mm(seasonic_focus_gx_850, 140).
psu_form_factor(seasonic_focus_gx_1000, atx). psu_length_mm(seasonic_focus_gx_1000, 140).
psu_form_factor(corsair_rm750e, atx). psu_length_mm(corsair_rm750e, 140).
psu_form_factor(corsair_rm850x, atx). psu_length_mm(corsair_rm850x, 160).
psu_form_factor(corsair_rm1000x, atx). psu_length_mm(corsair_rm1000x, 180).
psu_form_factor(be_quiet_pure_power_12m_750, atx). psu_length_mm(be_quiet_pure_power_12m_750, 160).
psu_form_factor(be_quiet_pure_power_12m_850, atx). psu_length_mm(be_quiet_pure_power_12m_850, 160).
psu_form_factor(msi_mpg_a850g_pcie5, atx). psu_length_mm(msi_mpg_a850g_pcie5, 150).
psu_form_factor(msi_mpg_a1000g_pcie5, atx). psu_length_mm(msi_mpg_a1000g_pcie5, 150).
psu_form_factor(corsair_sf750_sfx, sfx). psu_length_mm(corsair_sf750_sfx, 100).
psu_form_factor(coolermaster_v_sfx_gold_850, sfx). psu_length_mm(coolermaster_v_sfx_gold_850, 100).
psu_form_factor(silverstone_sx1000r_platinum, sfx_l). psu_length_mm(silverstone_sx1000r_platinum, 130).
psu_form_factor(silverstone_sx1000_lpt, sfx_l). psu_length_mm(silverstone_sx1000_lpt, 130).

% ----------------------------- Cooler catalog -------------------
component(noctua_nh_d15, cooler, 'Noctua NH-D15', noctua).
component(noctua_nh_u12a, cooler, 'Noctua NH-U12A', noctua).
component(noctua_nh_u12s, cooler, 'Noctua NH-U12S', noctua).
component(thermalright_peerless_assassin_120_se, cooler, 'Thermalright Peerless Assassin 120 SE', thermalright).
component(thermalright_phantom_spirit_120_se, cooler, 'Thermalright Phantom Spirit 120 SE', thermalright).
component(deepcool_ak620, cooler, 'DeepCool AK620', deepcool).
component(be_quiet_dark_rock_pro_5, cooler, 'be quiet! Dark Rock Pro 5', be_quiet).
component(arctic_liquid_freezer_iii_240, cooler, 'ARCTIC Liquid Freezer III 240', arctic).
component(corsair_h100i_elite_capellix_xt, cooler, 'Corsair iCUE H100i Elite Capellix XT', corsair).
component(msi_mag_coreliquid_360r_v2, cooler, 'MSI MAG CORELIQUID 360R V2', msi).
cooler_height_mm(noctua_nh_d15, 168).
cooler_type(noctua_nh_d15, air).
cooler_socket_support(noctua_nh_d15, am5). cooler_socket_support(noctua_nh_d15, am4).
cooler_socket_support(noctua_nh_d15, lga1700).
cooler_height_mm(noctua_nh_u12a, 158).
cooler_type(noctua_nh_u12a, air).
cooler_socket_support(noctua_nh_u12a, am5). cooler_socket_support(noctua_nh_u12a, am4).
cooler_socket_support(noctua_nh_u12a, lga1700).
cooler_height_mm(noctua_nh_u12s, 158).
cooler_type(noctua_nh_u12s, air).
cooler_socket_support(noctua_nh_u12s, am5). cooler_socket_support(noctua_nh_u12s, am4).
cooler_socket_support(noctua_nh_u12s, lga1700).
cooler_height_mm(thermalright_peerless_assassin_120_se, 155).
cooler_type(thermalright_peerless_assassin_120_se, air).
cooler_socket_support(thermalright_peerless_assassin_120_se, am5).
cooler_socket_support(thermalright_peerless_assassin_120_se, am4).
cooler_socket_support(thermalright_peerless_assassin_120_se, lga1700).
cooler_height_mm(thermalright_phantom_spirit_120_se, 154).
cooler_type(thermalright_phantom_spirit_120_se, air).
cooler_socket_support(thermalright_phantom_spirit_120_se, am5).
cooler_socket_support(thermalright_phantom_spirit_120_se, am4).
cooler_socket_support(thermalright_phantom_spirit_120_se, lga1700).
cooler_height_mm(deepcool_ak620, 160).
cooler_type(deepcool_ak620, air).
cooler_socket_support(deepcool_ak620, am5). cooler_socket_support(deepcool_ak620, am4).
cooler_socket_support(deepcool_ak620, lga1700).
cooler_height_mm(be_quiet_dark_rock_pro_5, 168).
cooler_type(be_quiet_dark_rock_pro_5, air).
cooler_socket_support(be_quiet_dark_rock_pro_5, am5).
cooler_socket_support(be_quiet_dark_rock_pro_5, am4).
cooler_socket_support(be_quiet_dark_rock_pro_5, lga1700).

% AIO radiator size is the nominal class; fit also depends on the case's
% supported mounting position and actual radiator thickness/length.
cooler_type(arctic_liquid_freezer_iii_240, liquid).
cooler_radiator_size_mm(arctic_liquid_freezer_iii_240, 240).
cooler_radiator_dimensions_mm(arctic_liquid_freezer_iii_240, 277, 120, 38).
cooler_socket_support(arctic_liquid_freezer_iii_240, am5).
cooler_socket_support(arctic_liquid_freezer_iii_240, am4).
cooler_socket_support(arctic_liquid_freezer_iii_240, lga1700).
cooler_type(corsair_h100i_elite_capellix_xt, liquid).
cooler_radiator_size_mm(corsair_h100i_elite_capellix_xt, 240).
cooler_radiator_dimensions_mm(corsair_h100i_elite_capellix_xt, 277, 120, 27).
cooler_socket_support(corsair_h100i_elite_capellix_xt, am5).
cooler_socket_support(corsair_h100i_elite_capellix_xt, am4).
cooler_socket_support(corsair_h100i_elite_capellix_xt, lga1700).
cooler_type(msi_mag_coreliquid_360r_v2, liquid).
cooler_radiator_size_mm(msi_mag_coreliquid_360r_v2, 360).
cooler_radiator_dimensions_mm(msi_mag_coreliquid_360r_v2, 394, 120, 27).
cooler_socket_support(msi_mag_coreliquid_360r_v2, am5).
cooler_socket_support(msi_mag_coreliquid_360r_v2, am4).
cooler_socket_support(msi_mag_coreliquid_360r_v2, lga1700).

% ----------------------- Additional rule helpers ----------------
memory_board_check(MemoryId, Board, Result) :-
    (   atom(MemoryId), memory(MemoryId, Type, _, _)
    ->  memory_board_check(Type, _, Board, Result)
    ;   Result = unknown
    ).

% cpu_socket(Id, Socket). cpu_tdp(Id, Watts).
cpu_socket(ryzen_5_7600, am5).
cpu_tdp(ryzen_5_7600, 65).
cpu_series(ryzen_5_7600, ryzen_7000).
cpu_socket(ryzen_5_5600, am4).
cpu_tdp(ryzen_5_5600, 65).
cpu_series(ryzen_5_5600, ryzen_5000).

% motherboard_socket(Id, Socket), motherboard_form_factor(Id, FormFactor).
% motherboard_memory(Id, Type), motherboard_max_memory_gb(Id, Capacity).
motherboard_socket(msi_pro_b650s_wifi, am5).
motherboard_form_factor(msi_pro_b650s_wifi, atx).
motherboard_memory(msi_pro_b650s_wifi, ddr5).
motherboard_max_memory_gb(msi_pro_b650s_wifi, 256).
motherboard_supported_cpu_series(msi_pro_b650s_wifi, ryzen_7000).
motherboard_supported_cpu_series(msi_pro_b650s_wifi, ryzen_8000).
motherboard_supported_cpu_series(msi_pro_b650s_wifi, ryzen_9000).

motherboard_socket(msi_b550m_pro_vdh_wifi, am4).
motherboard_form_factor(msi_b550m_pro_vdh_wifi, micro_atx).
motherboard_memory(msi_b550m_pro_vdh_wifi, ddr4).
motherboard_max_memory_gb(msi_b550m_pro_vdh_wifi, 128).
% Verify individual CPU models against the motherboard's manufacturer support list.
motherboard_supported_cpu_series(msi_b550m_pro_vdh_wifi, ryzen_3000).
motherboard_supported_cpu_series(msi_b550m_pro_vdh_wifi, ryzen_5000).

% memory(Id, Type, CapacityGB, SpeedMTs).

% case_form_factor_support(Id, FormFactor), case_gpu_clearance_mm(Id, Length),
% case_cooler_clearance_mm(Id, Height).
case_form_factor_support(msi_mag_forge_112r, atx).
case_form_factor_support(msi_mag_forge_112r, micro_atx).
case_form_factor_support(msi_mag_forge_112r, mini_itx).
case_gpu_clearance_mm(msi_mag_forge_112r, 330).
case_cooler_clearance_mm(msi_mag_forge_112r, 160).

% case_radiator_support(Case, MountPosition, NominalRadiatorSizeMm).
% A liquid cooler fits if its nominal size is supported at any one position.
% Position-specific thickness, RAM, GPU, and simultaneous-mount restrictions
% are not evaluated by this catalog-level check.
case_radiator_support_known(msi_mag_forge_112r).
case_radiator_support(msi_mag_forge_112r, front, 120).
case_radiator_support(msi_mag_forge_112r, front, 140).
case_radiator_support(msi_mag_forge_112r, front, 240).
case_radiator_support(msi_mag_forge_112r, top, 120).
case_radiator_support(msi_mag_forge_112r, top, 240).
case_radiator_support(msi_mag_forge_112r, rear, 120).

case_radiator_support_known(corsair_4000d_airflow).
case_radiator_support(corsair_4000d_airflow, front, 280).
case_radiator_support(corsair_4000d_airflow, front, 360).
case_radiator_support(corsair_4000d_airflow, top, 240).
case_radiator_support(corsair_4000d_airflow, top, 280).
case_radiator_support(corsair_4000d_airflow, rear, 120).
case_radiator_support_known(corsair_5000d_airflow).
case_radiator_support(corsair_5000d_airflow, front, 240).
case_radiator_support(corsair_5000d_airflow, front, 280).
case_radiator_support(corsair_5000d_airflow, front, 360).
case_radiator_support(corsair_5000d_airflow, top, 280).
case_radiator_support(corsair_5000d_airflow, top, 360).
case_radiator_support(corsair_5000d_airflow, rear, 120).
case_radiator_support(corsair_5000d_airflow, motherboard_tray, 240).
case_radiator_support(corsair_5000d_airflow, motherboard_tray, 360).
case_radiator_support_known(corsair_7000d_airflow).
case_radiator_support(corsair_7000d_airflow, front, 420).
case_radiator_support(corsair_7000d_airflow, front, 480).
case_radiator_support(corsair_7000d_airflow, front, 120).
case_radiator_support(corsair_7000d_airflow, front, 240).
case_radiator_support(corsair_7000d_airflow, front, 360).
case_radiator_support(corsair_7000d_airflow, top, 360).
case_radiator_support(corsair_7000d_airflow, top, 420).
case_radiator_support(corsair_7000d_airflow, top, 120).
case_radiator_support(corsair_7000d_airflow, top, 240).
case_radiator_support(corsair_7000d_airflow, top, 280).
case_radiator_support(corsair_7000d_airflow, rear, 120).
case_radiator_support(corsair_7000d_airflow, rear, 140).
case_radiator_support(corsair_7000d_airflow, motherboard_tray, 420).
case_radiator_support(corsair_7000d_airflow, motherboard_tray, 480).

case_radiator_support_known(nzxt_h5_flow).
case_radiator_support(nzxt_h5_flow, top, 240).
case_radiator_support(nzxt_h5_flow, top, 280). % low-profile memory required
case_radiator_support(nzxt_h5_flow, front, 280).
case_radiator_support(nzxt_h5_flow, front, 360).
case_radiator_support_known(nzxt_h7_flow).
case_radiator_support(nzxt_h7_flow, top, 240).
case_radiator_support(nzxt_h7_flow, top, 280).
case_radiator_support(nzxt_h7_flow, top, 360).
case_radiator_support(nzxt_h7_flow, front, 240).
case_radiator_support(nzxt_h7_flow, front, 360).
case_radiator_support(nzxt_h7_flow, front, 420).
case_radiator_support(nzxt_h7_flow, rear, 120).
case_radiator_support(nzxt_h7_flow, rear, 140).

case_radiator_support_known(fractal_pop_air).
case_radiator_support(fractal_pop_air, top, 120).
case_radiator_support(fractal_pop_air, top, 240).
case_radiator_support(fractal_pop_air, front, 120).
case_radiator_support(fractal_pop_air, front, 240).
case_radiator_support(fractal_pop_air, front, 280).
case_radiator_support(fractal_pop_air, rear, 120).
case_radiator_support_known(fractal_meshify_2).
case_radiator_support(fractal_meshify_2, top, 120).
case_radiator_support(fractal_meshify_2, top, 140).
case_radiator_support(fractal_meshify_2, top, 240).
case_radiator_support(fractal_meshify_2, top, 280).
case_radiator_support(fractal_meshify_2, top, 360).
case_radiator_support(fractal_meshify_2, top, 420).
case_radiator_support(fractal_meshify_2, front, 120).
case_radiator_support(fractal_meshify_2, front, 140).
case_radiator_support(fractal_meshify_2, front, 240).
case_radiator_support(fractal_meshify_2, front, 280).
case_radiator_support(fractal_meshify_2, front, 360).
case_radiator_support(fractal_meshify_2, bottom, 120).
case_radiator_support(fractal_meshify_2, bottom, 140).
case_radiator_support(fractal_meshify_2, bottom, 240).
case_radiator_support(fractal_meshify_2, bottom, 280).
case_radiator_support(fractal_meshify_2, rear, 120).

case_radiator_support_known(lian_li_lancool_216).
case_radiator_support(lian_li_lancool_216, front, 240).
case_radiator_support(lian_li_lancool_216, front, 280).
case_radiator_support(lian_li_lancool_216, front, 360).
case_radiator_support(lian_li_lancool_216, top, 240).
case_radiator_support(lian_li_lancool_216, top, 280).
case_radiator_support(lian_li_lancool_216, top, 360).
case_radiator_support(lian_li_lancool_216, bottom, 240).
case_radiator_support_known(phanteks_nv5).
case_radiator_support(phanteks_nv5, top, 120).
case_radiator_support(phanteks_nv5, top, 240).
case_radiator_support(phanteks_nv5, top, 360).
case_radiator_support(phanteks_nv5, side, 120).
case_radiator_support(phanteks_nv5, side, 240).
case_radiator_support(phanteks_nv5, side, 360).
case_radiator_support(phanteks_nv5, rear, 120).

case_radiator_support_known(msi_mag_pano_100r).
case_radiator_support(msi_mag_pano_100r, top, 120).
case_radiator_support(msi_mag_pano_100r, top, 240).
case_radiator_support(msi_mag_pano_100r, top, 360).
case_radiator_support(msi_mag_pano_100r, rear, 120).
case_radiator_support(msi_mag_pano_100r, side, 120).
case_radiator_support(msi_mag_pano_100r, side, 240).
case_radiator_support(msi_mag_pano_100r, side, 360).
case_radiator_support(msi_mag_pano_100r, bottom, 120).
case_radiator_support(msi_mag_pano_100r, bottom, 240).
case_radiator_support(msi_mag_pano_100r, bottom, 360).

% Product references and retrieval dates are maintained in REFERENCES.md.

% ------------------------ PSU sizing estimate -------------------
% Intel inputs use manufacturer Maximum Turbo Power; AMD inputs use default
% TDP from AMD product specifications as a consistent estimate input.
cpu_power_for_estimate(amd_ryzen_5_9600x, 65).
cpu_power_for_estimate(amd_ryzen_7_9700x, 65).
cpu_power_for_estimate(amd_ryzen_9_9900x, 120).
cpu_power_for_estimate(amd_ryzen_9_9950x, 170).
cpu_power_for_estimate(amd_ryzen_5_7600x, 105).
cpu_power_for_estimate(amd_ryzen_7_7800x3d, 120).
cpu_power_for_estimate(amd_ryzen_9_7950x, 170).
cpu_power_for_estimate(amd_ryzen_7_7700, 65).
cpu_power_for_estimate(amd_ryzen_5_5600x, 65).
cpu_power_for_estimate(amd_ryzen_7_5800x3d, 105).
cpu_power_for_estimate(amd_ryzen_3_4100, 65).
cpu_power_for_estimate(amd_ryzen_3_3100, 65).
cpu_power_for_estimate(intel_core_i3_14100, 110).
cpu_power_for_estimate(intel_core_i3_12100, 89).
cpu_power_for_estimate(intel_core_i5_14600k, 181).
cpu_power_for_estimate(intel_core_i5_14600kf, 181).
cpu_power_for_estimate(intel_core_i5_13600k, 181).
cpu_power_for_estimate(intel_core_i5_12600k, 150).
cpu_power_for_estimate(intel_core_i7_14700k, 253).
cpu_power_for_estimate(intel_core_i7_14700kf, 253).
cpu_power_for_estimate(intel_core_i7_13700k, 253).
cpu_power_for_estimate(intel_core_i7_12700k, 190).
cpu_power_for_estimate(intel_core_i9_14900k, 253).
cpu_power_for_estimate(intel_core_i9_14900kf, 253).
cpu_power_for_estimate(ryzen_5_7600, 65).
cpu_power_for_estimate(ryzen_5_5600, 65).

% Adjustable allowance for motherboard, RAM, storage, fans, and other devices.
other_system_power_allowance_w(100).
psu_headroom_factor(1.2).

estimated_system_power(Cpu, Gpu, EstimatedDrawW, RecommendedW) :-
    cpu_power_for_estimate(Cpu, CpuW),
    gpu_power_for_estimate(Gpu, GpuW),
    other_system_power_allowance_w(OtherW),
    psu_headroom_factor(Factor),
    EstimatedDrawW is CpuW + GpuW + OtherW,
    RecommendedW is ceiling(EstimatedDrawW * Factor).

% Check total-build estimated wattage against the selected PSU rating.
% Missing CPU or GPU power returns needs_verification.
psu_wattage_check(Cpu, Gpu, Psu, sufficient(RequiredW)) :-
    estimated_system_power(Cpu, Gpu, _, RequiredW),
    psu_wattage(Psu, RatedW), RatedW >= RequiredW, !.
psu_wattage_check(Cpu, Gpu, Psu, insufficient(RequiredW)) :-
    estimated_system_power(Cpu, Gpu, _, RequiredW),
    psu_wattage(Psu, RatedW), RatedW < RequiredW, !.
psu_wattage_check(_, _, _, needs_verification).

recommended_psu(Cpu, Gpu, Psu, RequiredW) :-
    estimated_system_power(Cpu, Gpu, _, RequiredW),
    psu_wattage(Psu, RatedW), RatedW >= RequiredW.

lowest_recommended_psu(Cpu, Gpu, Psu, RequiredW) :-
    estimated_system_power(Cpu, Gpu, _, RequiredW),
    setof(RatedW-Candidate,
          (psu_wattage(Candidate, RatedW), RatedW >= RequiredW),
          [_-Psu|_]).

% Compatibility checks. `unknown` is returned if required specifications are absent.
cpu_board_check(Cpu, Board, compatible) :-
    cpu_socket(Cpu, Socket), motherboard_socket(Board, Socket), !.
cpu_board_check(Cpu, Board, incompatible) :-
    cpu_socket(Cpu, CpuSocket), motherboard_socket(Board, BoardSocket),
    CpuSocket \= BoardSocket, !.
cpu_board_check(_, _, unknown).

memory_board_check(MemoryType, _, Board, compatible) :-
    motherboard_memory(Board, MemoryType), !.
memory_board_check(MemoryType, _, Board, incompatible) :-
    motherboard_memory(Board, Supported), MemoryType \= Supported, !.
memory_board_check(_, _, _, unknown).

board_case_check(Board, Case, compatible) :-
    motherboard_form_factor(Board, Form), case_form_factor_support(Case, Form), !.
board_case_check(Board, Case, incompatible) :-
    motherboard_form_factor(Board, Form),
    case_form_factor_support(Case, _),
    \+ case_form_factor_support(Case, Form), !.
board_case_check(_, _, unknown).

gpu_case_check(GpuLengthMm, Case, compatible) :-
    number(GpuLengthMm), case_gpu_clearance_mm(Case, Limit), GpuLengthMm =< Limit, !.
gpu_case_check(GpuLengthMm, Case, incompatible) :-
    number(GpuLengthMm), case_gpu_clearance_mm(Case, Limit), GpuLengthMm > Limit, !.
gpu_case_check(GpuId, Case, Result) :-
    atom(GpuId), gpu_dimensions_mm(GpuId, LengthMm, _, _),
    gpu_case_check(LengthMm, Case, Result), !.
gpu_case_check(_, _, unknown).

cooler_case_check(CoolerId, Case, compatible) :-
    atom(CoolerId), cooler_type(CoolerId, air),
    cooler_height_mm(CoolerId, HeightMm),
    case_cooler_clearance_mm(Case, Limit), HeightMm =< Limit, !.
cooler_case_check(CoolerId, Case, incompatible) :-
    atom(CoolerId), cooler_type(CoolerId, air),
    cooler_height_mm(CoolerId, HeightMm),
    case_cooler_clearance_mm(Case, Limit), HeightMm > Limit, !.
cooler_case_check(CoolerId, Case, compatible) :-
    atom(CoolerId), cooler_type(CoolerId, liquid),
    cooler_radiator_size_mm(CoolerId, Size),
    case_radiator_support(Case, _, Size), !.
cooler_case_check(CoolerId, Case, incompatible) :-
    atom(CoolerId), cooler_type(CoolerId, liquid),
    cooler_radiator_size_mm(CoolerId, _),
    case_radiator_support_known(Case), !.
cooler_case_check(CoolerHeightMm, Case, compatible) :-
    number(CoolerHeightMm),
    case_cooler_clearance_mm(Case, Limit), CoolerHeightMm =< Limit, !.
cooler_case_check(CoolerHeightMm, Case, incompatible) :-
    number(CoolerHeightMm),
    case_cooler_clearance_mm(Case, Limit), CoolerHeightMm > Limit, !.
cooler_case_check(_, _, unknown).

cooler_cpu_check(Cooler, Cpu, compatible) :-
    cooler_socket_support(Cooler, Socket), cpu_socket(Cpu, Socket), !.
cooler_cpu_check(Cooler, Cpu, incompatible) :-
    cooler_socket_support(Cooler, _), cpu_socket(Cpu, _), !.
cooler_cpu_check(_, _, needs_verification).

% Check a single drive for a suitable port or M.2 slot. PCIe generation and
% lane count affect speed. The compatibility check uses protocol and size.
storage_board_check(Drive, Board, Result) :-
    (   atom(Drive), atom(Board),
        storage_drive(Drive, _, FormFactor, Interface),
        motherboard_storage(Board, SataPorts, NvmeSizes, SataM2Sizes)
    ->  (   storage_connection_available(FormFactor, Interface, SataPorts, NvmeSizes, SataM2Sizes)
        ->  Result = compatible
        ;   Result = incompatible
        )
    ;   Result = unknown
    ).

storage_connection_available(m2(Size), nvme(_, _), _, NvmeSizes, _) :-
    memberchk(Size, NvmeSizes).
storage_connection_available(m2(Size), sata, _, _, SataM2Sizes) :-
    memberchk(Size, SataM2Sizes).
storage_connection_available(inch_2_5, sata, SataPorts, _, _) :-
    SataPorts > 0.
storage_connection_available(inch_3_5, sata, SataPorts, _, _) :-
    SataPorts > 0.

% full_build_check(+Build, -Verdict, -Checks)
% Use none for an unselected part. build/7 is shorthand for no storage.
% Checks contains check(Name, Result) terms for the caller to present.
full_build_check(build(Cpu, Board, Ram, Gpu, Cooler, Case, Psu), Verdict, Checks) :-
    full_build_check(build(Cpu, Board, Ram, Gpu, Cooler, Case, Psu, none), Verdict, Checks).
full_build_check(build(Cpu, Board, Ram, Gpu, Cooler, Case, Psu, Storage), Verdict, Checks) :-
    Required = [cpu-Cpu, motherboard-Board, memory-Ram, gpu-Gpu, cooler-Cooler, case-Case, psu-Psu],
    (   Storage == none
    ->  Selections = Required
    ;   Selections = [storage-Storage | Required]
    ),
    findall(check(selection(Category), Issue),
            (member(Category-Part, Selections), build_selection_issue(Category, Part, Issue)),
            Issues),
    (   Issues = []
    ->  build_component_checks(Cpu, Board, Ram, Gpu, Cooler, Case, Psu, Storage, Results)
    ;   Results = Issues
    ),
    build_verdict(Results, Verdict),
    Checks = Results.

build_selection_issue(_, Part, missing) :-
    (var(Part) ; Part == none), !.
build_selection_issue(Category, Part, invalid(Part)) :-
    \+ (atom(Part), component(Part, Category, _, _)).

build_component_checks(Cpu, Board, Ram, Gpu, Cooler, Case, Psu, Storage, Checks) :-
    cpu_board_check(Cpu, Board, CpuBoard),
    memory_board_check(Ram, Board, RamBoard),
    board_case_check(Board, Case, BoardCase),
    gpu_case_check(Gpu, Case, GpuCase),
    cooler_cpu_check(Cooler, Cpu, CoolerCpu),
    cooler_case_check(Cooler, Case, CoolerCase),
    psu_wattage_check(Cpu, Gpu, Psu, Wattage),
    Checks = [check(cpu_board, CpuBoard), check(memory_board, RamBoard),
              check(board_case, BoardCase), check(gpu_case, GpuCase),
              check(cooler_cpu, CoolerCpu), check(cooler_case, CoolerCase),
              check(psu_wattage, Wattage) | StorageChecks],
    (   Storage == none
    ->  StorageChecks = []
    ;   storage_board_check(Storage, Board, StorageBoard),
        StorageChecks = [check(storage_board, StorageBoard)]
    ).

build_verdict(Checks, Verdict) :-
    (   memberchk(check(_, missing), Checks)
    ->  Verdict = incomplete
    ;   (memberchk(check(_, incompatible), Checks)
        ; memberchk(check(_, insufficient(_)), Checks)
        ; memberchk(check(_, invalid(_)), Checks))
    ->  Verdict = incompatible
    ;   (memberchk(check(_, unknown), Checks)
        ; memberchk(check(_, needs_verification), Checks))
    ->  Verdict = needs_verification
    ;   Verdict = compatible
    ).

% Add missing facts only from official product pages/manuals/support lists.
