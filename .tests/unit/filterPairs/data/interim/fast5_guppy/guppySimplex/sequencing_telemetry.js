[
    {
        "aggregation": "segment", 
        "analysis_id": "418cf87e-7b87-4400-9f0f-200cec99dea3", 
        "basecall_1d": {
            "exit_status_dist": {
                "pass": 4
            }, 
            "qscore_dist_temp": [
                {
                    "count": 1, 
                    "mean_qscore": 10.0
                }, 
                {
                    "count": 2, 
                    "mean_qscore": 11.5
                }, 
                {
                    "count": 1, 
                    "mean_qscore": 12.5
                }
            ], 
            "qscore_sum_temp": {
                "count": 4, 
                "mean": 11.558698654174805, 
                "sum": 46.23479461669922
            }, 
            "read_len_events_sum_temp": 5626, 
            "seq_len_bases_dist_temp": [
                {
                    "count": 4, 
                    "length": 0.0
                }
            ], 
            "seq_len_bases_sum_temp": 4, 
            "seq_len_events_dist_temp": [
                {
                    "count": 4, 
                    "length": 1000.0
                }
            ], 
            "speed_bases_per_second_dist_temp": [
                {
                    "count": 4, 
                    "speed": 1.0
                }
            ], 
            "strand_median_pa": {
                "count": 4, 
                "mean": 107.0916748046875, 
                "sum": 428.36669921875
            }, 
            "strand_sd_pa": {
                "count": 4, 
                "mean": 20.445537567138672, 
                "sum": 81.78215026855469
            }
        }, 
        "channel_count": 2, 
        "context_tags": {
            "barcoding_enabled": "1", 
            "barcoding_kits": "sqk-nbd114-96", 
            "basecall_config_filename": "dna_r10.4.1_e8.2_400bps_5khz_fast.cfg", 
            "experiment_type": "genomic_dna", 
            "local_basecalling": "1", 
            "package": "bream4", 
            "package_version": "7.8.2", 
            "sample_frequency": "5000", 
            "selected_speed_bases_per_second": "400", 
            "sequencing_kit": "sqk-nbd114-96"
        }, 
        "latest_run_time": 3299.55712890625, 
        "levels_sums": {
            "count": 4, 
            "mean": 218.4430694580078, 
            "open_pore_level_sum": 873.77227783203125
        }, 
        "opts": {
            "barcode_kits": "SQK-NBD114-24", 
            "beam_width": "32", 
            "calib_max_sequence_length": "3800", 
            "calib_min_coverage": "0.600000", 
            "calib_min_sequence_length": "3000", 
            "calib_reference": "lambda_3.6kb.fasta", 
            "chunk_size": "2000", 
            "chunks_per_caller": "10000", 
            "chunks_per_runner": "512", 
            "compress_fastq": "1", 
            "config": "dna_r10.4.1_e8.2_400bps_5khz_hac.cfg", 
            "device": "cuda:all", 
            "do_read_splitting": "1", 
            "gpu_runners_per_device": "4", 
            "min_qscore": "10.000000", 
            "model_file": "template_r10.4.1_e8.2_400bps_5khz_hac.jsn", 
            "noisiest_section_scaling_max_size": "8000", 
            "overlap": "50", 
            "ping_segment_duration": "60", 
            "ping_url": "https://ping.oxfordnanoportal.com/basecall", 
            "progress_stats_frequency": "60.000000", 
            "qscore_offset": "-0.200000", 
            "qscore_scale": "0.950000", 
            "records_per_fastq": "0", 
            "recursive": "1", 
            "trim_min_events": "3", 
            "trim_strategy": "dna", 
            "trim_threshold": "2.500000", 
            "use_quantile_scaling": "1"
        }, 
        "read_count": 4, 
        "reads_per_channel_dist": [
            {
                "channel": 2, 
                "count": 2
            }, 
            {
                "channel": 4, 
                "count": 2
            }
        ], 
        "run_id": "3920989083e15ad8b64e00188ad4cf3e95553100", 
        "segment_duration": 60, 
        "segment_number": 1, 
        "segment_type": "guppy-acquisition", 
        "software": {
            "analysis": "1d_basecalling", 
            "name": "guppy-basecalling", 
            "version": "6.5.7+ca6d6af"
        }, 
        "tracking_id": {
            "asic_id": "84796944", 
            "asic_id_eeprom": "8230587", 
            "asic_temp": "34.182358", 
            "asic_version": "IA02D", 
            "configuration_version": "5.8.6", 
            "data_source": "real_device", 
            "device_id": "MN24615", 
            "device_type": "minion", 
            "distribution_status": "stable", 
            "distribution_version": "23.11.5", 
            "exp_script_name": "sequencing_MIN114_DNA_e8_2_400K:FLO-MIN114:SQK-NBD114-96:400", 
            "exp_script_purpose": "sequencing_run", 
            "exp_start_time": "2024-03-05T18:15:18.826193+01:00", 
            "flow_cell_id": "FAW98542", 
            "flow_cell_product_code": "FLO-MIN114", 
            "guppy_version": "7.2.13+fba8e8925", 
            "heatsink_temp": "35.125000", 
            "host_product_code": "unknown", 
            "host_product_serial_number": "", 
            "hostname": "nanopore-workstation", 
            "installation_type": "nc", 
            "is_simulated": "0", 
            "msg_id": "c04bf069-b685-4a8d-a9f6-c02b6aa3cc74", 
            "operating_system": "Windows 10.0.19045", 
            "protocol_group_id": "BBRseq04", 
            "protocol_run_id": "af49e3cc-6f93-44fd-a839-674c9ccf677c", 
            "protocol_start_time": "2024-03-05T18:12:12.692876+01:00", 
            "protocols_version": "7.8.2", 
            "run_id": "3920989083e15ad8b64e00188ad4cf3e95553100", 
            "sample_id": "BBRseq04", 
            "time_stamp": "2024-05-27T09:47:24Z", 
            "usb_config": "fx3_1.2.7#fpga_1.2.1#bulk#USB300", 
            "version": "5.8.7"
        }
    }, 
    {
        "aggregation": "cumulative", 
        "analysis_id": "418cf87e-7b87-4400-9f0f-200cec99dea3", 
        "basecall_1d": {
            "exit_status_dist": {
                "pass": 4
            }, 
            "qscore_dist_temp": [
                {
                    "count": 1, 
                    "mean_qscore": 10.0
                }, 
                {
                    "count": 2, 
                    "mean_qscore": 11.5
                }, 
                {
                    "count": 1, 
                    "mean_qscore": 12.5
                }
            ], 
            "qscore_sum_temp": {
                "count": 4, 
                "mean": 11.558698654174805, 
                "sum": 46.23479461669922
            }, 
            "read_len_events_sum_temp": 5626, 
            "seq_len_bases_dist_temp": [
                {
                    "count": 4, 
                    "length": 0.0
                }
            ], 
            "seq_len_bases_sum_temp": 4, 
            "seq_len_events_dist_temp": [
                {
                    "count": 4, 
                    "length": 1000.0
                }
            ], 
            "speed_bases_per_second_dist_temp": [
                {
                    "count": 4, 
                    "speed": 1.0
                }
            ], 
            "strand_median_pa": {
                "count": 4, 
                "mean": 107.0916748046875, 
                "sum": 428.36669921875
            }, 
            "strand_sd_pa": {
                "count": 4, 
                "mean": 20.445537567138672, 
                "sum": 81.78215026855469
            }
        }, 
        "channel_count": 2, 
        "context_tags": {
            "barcoding_enabled": "1", 
            "barcoding_kits": "sqk-nbd114-96", 
            "basecall_config_filename": "dna_r10.4.1_e8.2_400bps_5khz_fast.cfg", 
            "experiment_type": "genomic_dna", 
            "local_basecalling": "1", 
            "package": "bream4", 
            "package_version": "7.8.2", 
            "sample_frequency": "5000", 
            "selected_speed_bases_per_second": "400", 
            "sequencing_kit": "sqk-nbd114-96"
        }, 
        "latest_run_time": 3299.55712890625, 
        "levels_sums": {
            "count": 4, 
            "mean": 218.4430694580078, 
            "open_pore_level_sum": 873.77227783203125
        }, 
        "opts": {
            "barcode_kits": "SQK-NBD114-24", 
            "beam_width": "32", 
            "calib_max_sequence_length": "3800", 
            "calib_min_coverage": "0.600000", 
            "calib_min_sequence_length": "3000", 
            "calib_reference": "lambda_3.6kb.fasta", 
            "chunk_size": "2000", 
            "chunks_per_caller": "10000", 
            "chunks_per_runner": "512", 
            "compress_fastq": "1", 
            "config": "dna_r10.4.1_e8.2_400bps_5khz_hac.cfg", 
            "device": "cuda:all", 
            "do_read_splitting": "1", 
            "gpu_runners_per_device": "4", 
            "min_qscore": "10.000000", 
            "model_file": "template_r10.4.1_e8.2_400bps_5khz_hac.jsn", 
            "noisiest_section_scaling_max_size": "8000", 
            "overlap": "50", 
            "ping_segment_duration": "60", 
            "ping_url": "https://ping.oxfordnanoportal.com/basecall", 
            "progress_stats_frequency": "60.000000", 
            "qscore_offset": "-0.200000", 
            "qscore_scale": "0.950000", 
            "records_per_fastq": "0", 
            "recursive": "1", 
            "trim_min_events": "3", 
            "trim_strategy": "dna", 
            "trim_threshold": "2.500000", 
            "use_quantile_scaling": "1"
        }, 
        "read_count": 4, 
        "reads_per_channel_dist": [
            {
                "channel": 2, 
                "count": 2
            }, 
            {
                "channel": 4, 
                "count": 2
            }
        ], 
        "run_id": "3920989083e15ad8b64e00188ad4cf3e95553100", 
        "segment_duration": 60, 
        "segment_number": 1, 
        "segment_type": "guppy-acquisition", 
        "software": {
            "analysis": "1d_basecalling", 
            "name": "guppy-basecalling", 
            "version": "6.5.7+ca6d6af"
        }, 
        "tracking_id": {
            "asic_id": "84796944", 
            "asic_id_eeprom": "8230587", 
            "asic_temp": "34.182358", 
            "asic_version": "IA02D", 
            "configuration_version": "5.8.6", 
            "data_source": "real_device", 
            "device_id": "MN24615", 
            "device_type": "minion", 
            "distribution_status": "stable", 
            "distribution_version": "23.11.5", 
            "exp_script_name": "sequencing_MIN114_DNA_e8_2_400K:FLO-MIN114:SQK-NBD114-96:400", 
            "exp_script_purpose": "sequencing_run", 
            "exp_start_time": "2024-03-05T18:15:18.826193+01:00", 
            "flow_cell_id": "FAW98542", 
            "flow_cell_product_code": "FLO-MIN114", 
            "guppy_version": "7.2.13+fba8e8925", 
            "heatsink_temp": "35.125000", 
            "host_product_code": "unknown", 
            "host_product_serial_number": "", 
            "hostname": "nanopore-workstation", 
            "installation_type": "nc", 
            "is_simulated": "0", 
            "msg_id": "fa5105e2-99b3-4bf6-b44b-bace5e288ccd", 
            "operating_system": "Windows 10.0.19045", 
            "protocol_group_id": "BBRseq04", 
            "protocol_run_id": "af49e3cc-6f93-44fd-a839-674c9ccf677c", 
            "protocol_start_time": "2024-03-05T18:12:12.692876+01:00", 
            "protocols_version": "7.8.2", 
            "run_id": "3920989083e15ad8b64e00188ad4cf3e95553100", 
            "sample_id": "BBRseq04", 
            "time_stamp": "2024-05-27T09:47:24Z", 
            "usb_config": "fx3_1.2.7#fpga_1.2.1#bulk#USB300", 
            "version": "5.8.7"
        }
    }
]