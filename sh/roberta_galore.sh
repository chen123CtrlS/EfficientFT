export CUDA_VISIBLE_DEVICES=2
python /.../EfficientFT/run_galore.py \
    --model_name_or_path roberta-base \
    --target_modules query,value\
    --lr 1e-4\
    --lr_ratio 1.0\
    --task_name rte \
    --enable_galore \
    --lora_all_modules \
    --max_length 512 \
    --seed=1234 \
    --lora_r 8 \
    --galore_scale 4 \
    --per_device_train_batch_size 32 \
    --update_proj_gap 500 \
    --learning_rate 1e-4 \
    --num_train_epochs 10 \
    --output_dir EfficientFT/output\
    --data_path /.../data