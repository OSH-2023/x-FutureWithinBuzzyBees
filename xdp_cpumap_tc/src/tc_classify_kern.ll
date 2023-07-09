; ModuleID = 'tc_classify_kern.c'
source_filename = "tc_classify_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.anon.4 = type { [2 x i32]*, [64 x i32]*, i32*, %struct.txq_config*, [1 x i32]* }
%struct.txq_config = type { i16, i16 }
%struct.anon.5 = type { [2 x i32]*, [256 x i32]*, i32*, i32*, [1 x i32]* }
%struct.anon.6 = type { [11 x i32]*, [32767 x i32]*, %struct.ip_hash_key*, %struct.ip_hash_info*, [1 x i32]*, [1 x i32]* }
%struct.ip_hash_key = type { i32, %struct.in6_addr }
%struct.in6_addr = type { %union.anon.3 }
%union.anon.3 = type { [4 x i32] }
%struct.ip_hash_info = type { i32, i32 }
%struct.__sk_buff = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, [5 x i32], i32, i32, i32, i32, i32, i32, i32, i32, [4 x i32], [4 x i32], i32, i32, i32, %union.anon, i64, i32, i32, %union.anon.2 }
%union.anon = type { %struct.bpf_flow_keys* }
%struct.bpf_flow_keys = type { i16, i16, i16, i8, i8, i8, i8, i16, i16, i16, %union.anon.0, i32, i32 }
%union.anon.0 = type { %struct.anon.1 }
%struct.anon.1 = type { [4 x i32], [4 x i32] }
%union.anon.2 = type { %struct.bpf_sock* }
%struct.bpf_sock = type { i32, i32, i32, i32, i32, i32, i32, [4 x i32], i32, i16, i16, i32, [4 x i32], i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.iphdr = type { i8, i8, i16, i16, i16, i8, i8, i16, i32, i32 }
%struct.ipv6hdr = type { i8, [3 x i8], i16, i8, i8, %struct.in6_addr, %struct.in6_addr }

@map_txq_config = dso_local global %struct.anon.4 zeroinitializer, section ".maps", align 8, !dbg !0
@__const.tc_iphash_to_cpu.____fmt = private unnamed_addr constant [43 x i8] c"(tc) Misconf: CPU:%u no conf (curr qm:%d)\0A\00", align 1
@__const.tc_iphash_to_cpu.____fmt.1 = private unnamed_addr constant [45 x i8] c"(tc) Cannot parse L2: L3off:%llu proto:0x%x\0A\00", align 1
@map_ifindex_type = dso_local global %struct.anon.5 zeroinitializer, section ".maps", align 8, !dbg !76
@map_ip_hash = dso_local global %struct.anon.6 zeroinitializer, section ".maps", align 8, !dbg !18
@__const.tc_iphash_to_cpu.____fmt.2 = private unnamed_addr constant [64 x i8] c"(tc) Misconf: FAILED lookup IP:0x%x ifindex_ingress:%d prio:%x\0A\00", align 1
@__const.tc_iphash_to_cpu.____fmt.3 = private unnamed_addr constant [51 x i8] c"(tc) Mismatch: Curr-CPU:%u but IP:%x wants CPU:%u\0A\00", align 1
@__const.tc_iphash_to_cpu.____fmt.4 = private unnamed_addr constant [61 x i8] c"(tc) Mismatch: more-info ifindex:%d ingress:%d skb->prio:%x\0A\00", align 1
@__const.tc_iphash_to_cpu.____fmt.5 = private unnamed_addr constant [40 x i8] c"(tc) Misconf: TC major(%d) mismatch %x\0A\00", align 1
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !12
@llvm.used = appending global [5 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon.5* @map_ifindex_type to i8*), i8* bitcast (%struct.anon.6* @map_ip_hash to i8*), i8* bitcast (%struct.anon.4* @map_txq_config to i8*), i8* bitcast (i32 (%struct.__sk_buff*)* @tc_iphash_to_cpu to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @tc_iphash_to_cpu(%struct.__sk_buff* nocapture %0) #0 section "tc" !dbg !134 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca %struct.ip_hash_key, align 4
  %5 = alloca [43 x i8], align 1
  %6 = alloca [45 x i8], align 1
  %7 = alloca [64 x i8], align 1
  %8 = alloca [51 x i8], align 1
  %9 = alloca [61 x i8], align 1
  %10 = alloca [40 x i8], align 1
  call void @llvm.dbg.value(metadata %struct.__sk_buff* %0, metadata !229, metadata !DIExpression()), !dbg !293
  %11 = bitcast i32* %2 to i8*, !dbg !294
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %11) #3, !dbg !294
  %12 = tail call i32 inttoptr (i64 8 to i32 ()*)() #3, !dbg !295
  call void @llvm.dbg.value(metadata i32 %12, metadata !230, metadata !DIExpression()), !dbg !293
  store i32 %12, i32* %2, align 4, !dbg !296, !tbaa !297
  %13 = bitcast i32* %3 to i8*, !dbg !301
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %13) #3, !dbg !301
  call void @llvm.dbg.value(metadata i32 0, metadata !235, metadata !DIExpression()), !dbg !293
  %14 = getelementptr inbounds %struct.__sk_buff, %struct.__sk_buff* %0, i64 0, i32 16, !dbg !302
  %15 = load i32, i32* %14, align 8, !dbg !302, !tbaa !303
  %16 = zext i32 %15 to i64, !dbg !306
  %17 = inttoptr i64 %16 to i8*, !dbg !307
  call void @llvm.dbg.value(metadata i8* %17, metadata !236, metadata !DIExpression()), !dbg !293
  %18 = getelementptr inbounds %struct.__sk_buff, %struct.__sk_buff* %0, i64 0, i32 15, !dbg !308
  %19 = load i32, i32* %18, align 4, !dbg !308, !tbaa !309
  %20 = zext i32 %19 to i64, !dbg !310
  %21 = inttoptr i64 %20 to %struct.ethhdr*, !dbg !311
  call void @llvm.dbg.value(metadata %struct.ethhdr* %21, metadata !237, metadata !DIExpression()), !dbg !293
  call void @llvm.dbg.value(metadata %struct.ethhdr* %21, metadata !238, metadata !DIExpression()), !dbg !293
  call void @llvm.dbg.value(metadata i16 0, metadata !249, metadata !DIExpression()), !dbg !293
  call void @llvm.dbg.value(metadata i32 0, metadata !250, metadata !DIExpression()), !dbg !293
  %22 = bitcast %struct.ip_hash_key* %4 to i8*, !dbg !312
  call void @llvm.lifetime.start.p0i8(i64 20, i8* nonnull %22) #3, !dbg !312
  call void @llvm.dbg.declare(metadata %struct.ip_hash_key* %4, metadata !251, metadata !DIExpression()), !dbg !313
  call void @llvm.dbg.value(metadata i32* %2, metadata !230, metadata !DIExpression(DW_OP_deref)), !dbg !293
  %23 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.4* @map_txq_config to i8*), i8* nonnull %11) #3, !dbg !314
  call void @llvm.dbg.value(metadata i8* %23, metadata !232, metadata !DIExpression()), !dbg !293
  %24 = icmp eq i8* %23, null, !dbg !315
  br i1 %24, label %205, label %25, !dbg !317

25:                                               ; preds = %1
  %26 = bitcast i8* %23 to i16*, !dbg !318
  %27 = load i16, i16* %26, align 2, !dbg !318, !tbaa !319
  %28 = icmp eq i16 %27, 0, !dbg !322
  br i1 %28, label %32, label %29, !dbg !323

29:                                               ; preds = %25
  %30 = zext i16 %27 to i32, !dbg !324
  %31 = getelementptr inbounds %struct.__sk_buff, %struct.__sk_buff* %0, i64 0, i32 3, !dbg !325
  store i32 %30, i32* %31, align 4, !dbg !327, !tbaa !328
  br label %38, !dbg !329

32:                                               ; preds = %25
  %33 = getelementptr inbounds [43 x i8], [43 x i8]* %5, i64 0, i64 0, !dbg !330
  call void @llvm.lifetime.start.p0i8(i64 43, i8* nonnull %33) #3, !dbg !330
  call void @llvm.dbg.declare(metadata [43 x i8]* %5, metadata !252, metadata !DIExpression()), !dbg !330
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(43) %33, i8* nonnull align 1 dereferenceable(43) getelementptr inbounds ([43 x i8], [43 x i8]* @__const.tc_iphash_to_cpu.____fmt, i64 0, i64 0), i64 43, i1 false), !dbg !330
  %34 = load i32, i32* %2, align 4, !dbg !330, !tbaa !297
  call void @llvm.dbg.value(metadata i32 %34, metadata !230, metadata !DIExpression()), !dbg !293
  %35 = getelementptr inbounds %struct.__sk_buff, %struct.__sk_buff* %0, i64 0, i32 3, !dbg !330
  %36 = load i32, i32* %35, align 4, !dbg !330, !tbaa !328
  %37 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* nonnull %33, i32 43, i32 %34, i32 %36) #3, !dbg !330
  call void @llvm.lifetime.end.p0i8(i64 43, i8* nonnull %33) #3, !dbg !331
  br label %38

38:                                               ; preds = %32, %29
  %39 = getelementptr inbounds %struct.__sk_buff, %struct.__sk_buff* %0, i64 0, i32 9, !dbg !332
  %40 = load i32, i32* %39, align 4, !dbg !332, !tbaa !334
  %41 = icmp eq i32 %40, 0, !dbg !335
  br i1 %41, label %42, label %54, !dbg !336

42:                                               ; preds = %38
  call void @llvm.dbg.value(metadata %struct.__sk_buff* %0, metadata !337, metadata !DIExpression()), !dbg !347
  call void @llvm.dbg.value(metadata i8* %23, metadata !342, metadata !DIExpression()), !dbg !347
  %43 = getelementptr inbounds i8, i8* %23, i64 2, !dbg !350
  %44 = bitcast i8* %43 to i16*, !dbg !350
  %45 = load i16, i16* %44, align 2, !dbg !350, !tbaa !351
  %46 = zext i16 %45 to i32, !dbg !352
  %47 = shl nuw i32 %46, 16, !dbg !353
  call void @llvm.dbg.value(metadata i32 %47, metadata !343, metadata !DIExpression()), !dbg !347
  %48 = getelementptr inbounds %struct.__sk_buff, %struct.__sk_buff* %0, i64 0, i32 8, !dbg !354
  %49 = load i32, i32* %48, align 8, !dbg !354, !tbaa !355
  %50 = icmp eq i32 %49, 0, !dbg !356
  %51 = and i32 %49, 65535, !dbg !357
  %52 = select i1 %50, i32 3, i32 %51, !dbg !357
  %53 = or i32 %52, %47, !dbg !358
  store i32 %53, i32* %48, align 8, !dbg !358, !tbaa !355
  br label %205, !dbg !359

54:                                               ; preds = %38
  call void @llvm.dbg.value(metadata %struct.__sk_buff* %0, metadata !360, metadata !DIExpression()), !dbg !371
  call void @llvm.dbg.value(metadata i8* %23, metadata !366, metadata !DIExpression()), !dbg !371
  %55 = getelementptr inbounds %struct.__sk_buff, %struct.__sk_buff* %0, i64 0, i32 8, !dbg !374
  %56 = load i32, i32* %55, align 8, !dbg !374, !tbaa !355
  %57 = icmp eq i32 %56, 0, !dbg !376
  br i1 %57, label %69, label %58, !dbg !377

58:                                               ; preds = %54
  %59 = and i32 %56, 65535, !dbg !378
  call void @llvm.dbg.value(metadata i32 %59, metadata !367, metadata !DIExpression()), !dbg !371
  %60 = add nsw i32 %59, -3, !dbg !379
  %61 = icmp ult i32 %60, 7, !dbg !379
  br i1 %61, label %62, label %69, !dbg !379

62:                                               ; preds = %58
  %63 = getelementptr inbounds i8, i8* %23, i64 2, !dbg !380
  %64 = bitcast i8* %63 to i16*, !dbg !380
  %65 = load i16, i16* %64, align 2, !dbg !380, !tbaa !351
  %66 = zext i16 %65 to i32, !dbg !381
  %67 = shl nuw i32 %66, 16, !dbg !382
  call void @llvm.dbg.value(metadata i32 %67, metadata !368, metadata !DIExpression()), !dbg !383
  %68 = or i32 %67, %59, !dbg !384
  store i32 %68, i32* %55, align 8, !dbg !385, !tbaa !355
  br label %205, !dbg !386

69:                                               ; preds = %54, %58
  call void @llvm.dbg.value(metadata %struct.ethhdr* %21, metadata !387, metadata !DIExpression()) #3, !dbg !409
  call void @llvm.dbg.value(metadata i8* %17, metadata !393, metadata !DIExpression()) #3, !dbg !409
  call void @llvm.dbg.value(metadata i64 14, metadata !397, metadata !DIExpression()) #3, !dbg !409
  %70 = getelementptr %struct.ethhdr, %struct.ethhdr* %21, i64 0, i32 0, i64 14, !dbg !411
  %71 = icmp ugt i8* %70, %17, !dbg !413
  br i1 %71, label %97, label %72, !dbg !414

72:                                               ; preds = %69
  %73 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %21, i64 0, i32 2, !dbg !415
  %74 = load i16, i16* %73, align 1, !dbg !415, !tbaa !416
  call void @llvm.dbg.value(metadata i16 %74, metadata !396, metadata !DIExpression()) #3, !dbg !409
  %75 = shl i16 %74, 8
  %76 = icmp ult i16 %75, 1536, !dbg !418
  br i1 %76, label %97, label %77, !dbg !420

77:                                               ; preds = %72
  switch i16 %74, label %85 [
    i16 129, label %78
    i16 -22392, label %78
  ], !dbg !421

78:                                               ; preds = %77, %77
  call void @llvm.dbg.value(metadata i8* %70, metadata !398, metadata !DIExpression()) #3, !dbg !422
  call void @llvm.dbg.value(metadata i64 18, metadata !397, metadata !DIExpression()) #3, !dbg !409
  %79 = getelementptr %struct.ethhdr, %struct.ethhdr* %21, i64 0, i32 0, i64 18, !dbg !423
  %80 = icmp ugt i8* %79, %17, !dbg !425
  br i1 %80, label %97, label %81, !dbg !426

81:                                               ; preds = %78
  call void @llvm.dbg.value(metadata i8* %70, metadata !398, metadata !DIExpression()) #3, !dbg !422
  %82 = getelementptr %struct.ethhdr, %struct.ethhdr* %21, i64 0, i32 0, i64 16, !dbg !427
  %83 = bitcast i8* %82 to i16*, !dbg !427
  %84 = load i16, i16* %83, align 2, !dbg !427, !tbaa !428
  call void @llvm.dbg.value(metadata i16 %84, metadata !396, metadata !DIExpression()) #3, !dbg !409
  br label %85

85:                                               ; preds = %81, %77
  %86 = phi i64 [ 14, %77 ], [ 18, %81 ], !dbg !409
  %87 = phi i16 [ %74, %77 ], [ %84, %81 ], !dbg !430
  call void @llvm.dbg.value(metadata i16 %87, metadata !396, metadata !DIExpression()) #3, !dbg !409
  call void @llvm.dbg.value(metadata i64 %86, metadata !397, metadata !DIExpression()) #3, !dbg !409
  switch i16 %87, label %100 [
    i16 129, label %88
    i16 -22392, label %88
  ], !dbg !431

88:                                               ; preds = %85, %85
  call void @llvm.dbg.value(metadata i8* undef, metadata !406, metadata !DIExpression()) #3, !dbg !432
  %89 = add nuw nsw i64 %86, 4, !dbg !433
  call void @llvm.dbg.value(metadata i64 %89, metadata !397, metadata !DIExpression()) #3, !dbg !409
  %90 = getelementptr %struct.ethhdr, %struct.ethhdr* %21, i64 0, i32 0, i64 %89, !dbg !434
  %91 = icmp ugt i8* %90, %17, !dbg !436
  br i1 %91, label %97, label %92, !dbg !437

92:                                               ; preds = %88
  %93 = getelementptr %struct.ethhdr, %struct.ethhdr* %21, i64 0, i32 0, i64 %86, !dbg !438
  call void @llvm.dbg.value(metadata i8* %93, metadata !406, metadata !DIExpression()) #3, !dbg !432
  call void @llvm.dbg.value(metadata i8* %93, metadata !406, metadata !DIExpression()) #3, !dbg !432
  %94 = getelementptr inbounds i8, i8* %93, i64 2, !dbg !439
  %95 = bitcast i8* %94 to i16*, !dbg !439
  %96 = load i16, i16* %95, align 2, !dbg !439, !tbaa !428
  call void @llvm.dbg.value(metadata i16 %96, metadata !396, metadata !DIExpression()) #3, !dbg !409
  br label %100

97:                                               ; preds = %69, %72, %78, %88
  %98 = getelementptr inbounds [45 x i8], [45 x i8]* %6, i64 0, i64 0, !dbg !440
  call void @llvm.lifetime.start.p0i8(i64 45, i8* nonnull %98) #3, !dbg !440
  call void @llvm.dbg.declare(metadata [45 x i8]* %6, metadata !259, metadata !DIExpression()), !dbg !440
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(45) %98, i8* nonnull align 1 dereferenceable(45) getelementptr inbounds ([45 x i8], [45 x i8]* @__const.tc_iphash_to_cpu.____fmt.1, i64 0, i64 0), i64 45, i1 false), !dbg !440
  call void @llvm.dbg.value(metadata i64 %101, metadata !250, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !293
  call void @llvm.dbg.value(metadata i16 %109, metadata !249, metadata !DIExpression()), !dbg !293
  %99 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* nonnull %98, i32 45, i32 0, i32 0) #3, !dbg !440
  call void @llvm.lifetime.end.p0i8(i64 45, i8* nonnull %98) #3, !dbg !441
  br label %205, !dbg !442

100:                                              ; preds = %92, %85
  %101 = phi i64 [ %86, %85 ], [ %89, %92 ], !dbg !409
  %102 = phi i16 [ %87, %85 ], [ %96, %92 ], !dbg !430
  call void @llvm.dbg.value(metadata i16 %102, metadata !396, metadata !DIExpression()) #3, !dbg !409
  call void @llvm.dbg.value(metadata i64 %101, metadata !397, metadata !DIExpression()) #3, !dbg !409
  %103 = getelementptr inbounds %struct.__sk_buff, %struct.__sk_buff* %0, i64 0, i32 10, !dbg !443
  %104 = load i32, i32* %103, align 8, !dbg !443, !tbaa !444
  call void @llvm.dbg.value(metadata i32 %104, metadata !234, metadata !DIExpression()), !dbg !293
  store i32 %104, i32* %3, align 4, !dbg !445, !tbaa !297
  call void @llvm.dbg.value(metadata i32* %3, metadata !234, metadata !DIExpression(DW_OP_deref)), !dbg !293
  %105 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.5* @map_ifindex_type to i8*), i8* nonnull %13) #3, !dbg !446
  %106 = bitcast i8* %105 to i32*, !dbg !446
  call void @llvm.dbg.value(metadata i32* %106, metadata !233, metadata !DIExpression()), !dbg !293
  %107 = icmp eq i8* %105, null, !dbg !447
  br i1 %107, label %205, label %108, !dbg !449

108:                                              ; preds = %100
  %109 = call i16 @llvm.bswap.i16(i16 %102) #3
  %110 = getelementptr inbounds %struct.ip_hash_key, %struct.ip_hash_key* %4, i64 0, i32 0, !dbg !450
  store i32 128, i32* %110, align 4, !dbg !451, !tbaa !452
  %111 = getelementptr inbounds %struct.ip_hash_key, %struct.ip_hash_key* %4, i64 0, i32 1, i32 0, i32 0, i64 0, !dbg !455
  %112 = getelementptr inbounds %struct.ip_hash_key, %struct.ip_hash_key* %4, i64 0, i32 1, i32 0, i32 0, i64 3, !dbg !456
  call void @llvm.dbg.value(metadata i16 undef, metadata !249, metadata !DIExpression()), !dbg !293
  %113 = bitcast i32* %111 to i8*, !dbg !457
  call void @llvm.memset.p0i8.i64(i8* nonnull align 4 dereferenceable(16) %113, i8 -1, i64 16, i1 false), !dbg !458
  switch i16 %109, label %205 [
    i16 2048, label %114
    i16 -31011, label %135
  ], !dbg !457

114:                                              ; preds = %108
  call void @llvm.dbg.value(metadata i64 %101, metadata !250, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !293
  call void @llvm.dbg.value(metadata %struct.__sk_buff* %0, metadata !459, metadata !DIExpression()), !dbg !487
  call void @llvm.dbg.value(metadata i64 %101, metadata !464, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !487
  call void @llvm.dbg.value(metadata i32 undef, metadata !465, metadata !DIExpression()), !dbg !487
  call void @llvm.dbg.value(metadata %struct.ip_hash_key* %4, metadata !466, metadata !DIExpression()), !dbg !487
  %115 = load i32, i32* %14, align 8, !dbg !490, !tbaa !303
  %116 = zext i32 %115 to i64, !dbg !491
  call void @llvm.dbg.value(metadata i64 %116, metadata !467, metadata !DIExpression()), !dbg !487
  %117 = load i32, i32* %18, align 4, !dbg !492, !tbaa !309
  %118 = zext i32 %117 to i64, !dbg !493
  %119 = inttoptr i64 %118 to i8*, !dbg !494
  call void @llvm.dbg.value(metadata i8* %119, metadata !468, metadata !DIExpression()), !dbg !487
  %120 = getelementptr i8, i8* %119, i64 %101, !dbg !495
  call void @llvm.dbg.value(metadata i8* %120, metadata !469, metadata !DIExpression()), !dbg !487
  call void @llvm.dbg.value(metadata i32 0, metadata !486, metadata !DIExpression()), !dbg !487
  %121 = getelementptr inbounds i8, i8* %120, i64 20, !dbg !496
  %122 = bitcast i8* %121 to %struct.iphdr*, !dbg !496
  %123 = inttoptr i64 %116 to %struct.iphdr*, !dbg !498
  %124 = icmp ugt %struct.iphdr* %122, %123, !dbg !499
  br i1 %124, label %156, label %125, !dbg !500

125:                                              ; preds = %114
  %126 = load i32, i32* %106, align 4, !dbg !501, !tbaa !297
  call void @llvm.dbg.value(metadata i32 %126, metadata !465, metadata !DIExpression()), !dbg !487
  switch i32 %126, label %133 [
    i32 1, label %128
    i32 2, label %127
  ], !dbg !502

127:                                              ; preds = %125
  call void @llvm.dbg.value(metadata i32 %132, metadata !486, metadata !DIExpression()), !dbg !487
  br label %128, !dbg !503

128:                                              ; preds = %125, %127
  %129 = phi i64 [ 16, %127 ], [ 12, %125 ]
  %130 = getelementptr inbounds i8, i8* %120, i64 %129, !dbg !505
  %131 = bitcast i8* %130 to i32*, !dbg !505
  %132 = load i32, i32* %131, align 4, !dbg !505, !tbaa !297
  br label %133, !dbg !506

133:                                              ; preds = %128, %125
  %134 = phi i32 [ 0, %125 ], [ %132, %128 ], !dbg !505
  call void @llvm.dbg.value(metadata i32 %134, metadata !486, metadata !DIExpression()), !dbg !487
  store i32 %134, i32* %112, align 4, !dbg !506, !tbaa !507
  br label %156, !dbg !508

135:                                              ; preds = %108
  call void @llvm.dbg.value(metadata i64 %101, metadata !250, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !293
  call void @llvm.dbg.value(metadata %struct.__sk_buff* %0, metadata !509, metadata !DIExpression()) #3, !dbg !533
  call void @llvm.dbg.value(metadata i64 %101, metadata !512, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #3, !dbg !533
  call void @llvm.dbg.value(metadata i32 undef, metadata !513, metadata !DIExpression()) #3, !dbg !533
  call void @llvm.dbg.value(metadata %struct.ip_hash_key* %4, metadata !514, metadata !DIExpression()) #3, !dbg !533
  %136 = load i32, i32* %14, align 8, !dbg !535, !tbaa !303
  %137 = zext i32 %136 to i64, !dbg !536
  call void @llvm.dbg.value(metadata i64 %137, metadata !515, metadata !DIExpression()) #3, !dbg !533
  %138 = load i32, i32* %18, align 4, !dbg !537, !tbaa !309
  %139 = zext i32 %138 to i64, !dbg !538
  %140 = inttoptr i64 %139 to i8*, !dbg !539
  call void @llvm.dbg.value(metadata i8* %140, metadata !516, metadata !DIExpression()) #3, !dbg !533
  %141 = getelementptr i8, i8* %140, i64 %101, !dbg !540
  call void @llvm.dbg.value(metadata i8* %141, metadata !517, metadata !DIExpression()) #3, !dbg !533
  %142 = getelementptr inbounds i8, i8* %141, i64 40, !dbg !541
  %143 = bitcast i8* %142 to %struct.ipv6hdr*, !dbg !541
  %144 = inttoptr i64 %137 to %struct.ipv6hdr*, !dbg !543
  %145 = icmp ugt %struct.ipv6hdr* %143, %144, !dbg !544
  br i1 %145, label %156, label %146, !dbg !545

146:                                              ; preds = %135
  %147 = load i32, i32* %106, align 4, !dbg !546, !tbaa !297
  call void @llvm.dbg.value(metadata i32 %147, metadata !513, metadata !DIExpression()) #3, !dbg !533
  switch i32 %147, label %156 [
    i32 1, label %148
    i32 2, label %152
  ], !dbg !547

148:                                              ; preds = %146
  %149 = getelementptr inbounds %struct.ip_hash_key, %struct.ip_hash_key* %4, i64 0, i32 1, !dbg !548
  %150 = getelementptr inbounds i8, i8* %141, i64 8, !dbg !550
  %151 = bitcast %struct.in6_addr* %149 to i8*, !dbg !550
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(16) %151, i8* nonnull align 4 dereferenceable(16) %150, i64 16, i1 false) #3, !dbg !550, !tbaa.struct !551
  br label %156, !dbg !552

152:                                              ; preds = %146
  %153 = getelementptr inbounds %struct.ip_hash_key, %struct.ip_hash_key* %4, i64 0, i32 1, !dbg !553
  %154 = getelementptr inbounds i8, i8* %141, i64 24, !dbg !554
  %155 = bitcast %struct.in6_addr* %153 to i8*, !dbg !554
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(16) %155, i8* nonnull align 4 dereferenceable(16) %154, i64 16, i1 false) #3, !dbg !554, !tbaa.struct !551
  br label %156, !dbg !555

156:                                              ; preds = %152, %148, %146, %135, %133, %114
  %157 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.6* @map_ip_hash to i8*), i8* nonnull %22) #3, !dbg !556
  call void @llvm.dbg.value(metadata i8* %157, metadata !231, metadata !DIExpression()), !dbg !293
  %158 = icmp eq i8* %157, null, !dbg !557
  br i1 %158, label %159, label %168, !dbg !558

159:                                              ; preds = %156
  store i32 128, i32* %110, align 4, !dbg !559, !tbaa !452
  store i32 -1, i32* %112, align 4, !dbg !560, !tbaa !507
  %160 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.6* @map_ip_hash to i8*), i8* nonnull %22) #3, !dbg !561
  call void @llvm.dbg.value(metadata i8* %160, metadata !231, metadata !DIExpression()), !dbg !293
  %161 = icmp eq i8* %160, null, !dbg !562
  br i1 %161, label %162, label %168, !dbg !563

162:                                              ; preds = %159
  %163 = getelementptr inbounds [64 x i8], [64 x i8]* %7, i64 0, i64 0, !dbg !564
  call void @llvm.lifetime.start.p0i8(i64 64, i8* nonnull %163) #3, !dbg !564
  call void @llvm.dbg.declare(metadata [64 x i8]* %7, metadata !266, metadata !DIExpression()), !dbg !564
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(64) %163, i8* nonnull align 1 dereferenceable(64) getelementptr inbounds ([64 x i8], [64 x i8]* @__const.tc_iphash_to_cpu.____fmt.2, i64 0, i64 0), i64 64, i1 false), !dbg !564
  %164 = load i32, i32* %112, align 4, !dbg !564, !tbaa !507
  %165 = load i32, i32* %39, align 4, !dbg !564, !tbaa !334
  %166 = load i32, i32* %55, align 8, !dbg !564, !tbaa !355
  %167 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* nonnull %163, i32 64, i32 %164, i32 %165, i32 %166) #3, !dbg !564
  call void @llvm.lifetime.end.p0i8(i64 64, i8* nonnull %163) #3, !dbg !565
  br label %205, !dbg !566

168:                                              ; preds = %159, %156
  %169 = phi i8* [ %157, %156 ], [ %160, %159 ]
  call void @llvm.dbg.value(metadata i8* %169, metadata !231, metadata !DIExpression()), !dbg !293
  %170 = bitcast i8* %169 to i32*, !dbg !567
  %171 = load i32, i32* %170, align 4, !dbg !567, !tbaa !568
  %172 = load i32, i32* %2, align 4, !dbg !570, !tbaa !297
  call void @llvm.dbg.value(metadata i32 %172, metadata !230, metadata !DIExpression()), !dbg !293
  %173 = icmp eq i32 %171, %172, !dbg !571
  br i1 %173, label %184, label %174, !dbg !572

174:                                              ; preds = %168
  %175 = getelementptr inbounds [51 x i8], [51 x i8]* %8, i64 0, i64 0, !dbg !573
  call void @llvm.lifetime.start.p0i8(i64 51, i8* nonnull %175) #3, !dbg !573
  call void @llvm.dbg.declare(metadata [51 x i8]* %8, metadata !273, metadata !DIExpression()), !dbg !573
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(51) %175, i8* nonnull align 1 dereferenceable(51) getelementptr inbounds ([51 x i8], [51 x i8]* @__const.tc_iphash_to_cpu.____fmt.3, i64 0, i64 0), i64 51, i1 false), !dbg !573
  call void @llvm.dbg.value(metadata i32 %172, metadata !230, metadata !DIExpression()), !dbg !293
  %176 = load i32, i32* %112, align 4, !dbg !573, !tbaa !507
  %177 = load i32, i32* %170, align 4, !dbg !573, !tbaa !568
  %178 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* nonnull %175, i32 51, i32 %172, i32 %176, i32 %177) #3, !dbg !573
  call void @llvm.lifetime.end.p0i8(i64 51, i8* nonnull %175) #3, !dbg !574
  %179 = getelementptr inbounds [61 x i8], [61 x i8]* %9, i64 0, i64 0, !dbg !575
  call void @llvm.lifetime.start.p0i8(i64 61, i8* nonnull %179) #3, !dbg !575
  call void @llvm.dbg.declare(metadata [61 x i8]* %9, metadata !280, metadata !DIExpression()), !dbg !575
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(61) %179, i8* nonnull align 1 dereferenceable(61) getelementptr inbounds ([61 x i8], [61 x i8]* @__const.tc_iphash_to_cpu.____fmt.4, i64 0, i64 0), i64 61, i1 false), !dbg !575
  %180 = load i32, i32* %103, align 8, !dbg !575, !tbaa !444
  %181 = load i32, i32* %39, align 4, !dbg !575, !tbaa !334
  %182 = load i32, i32* %55, align 8, !dbg !575, !tbaa !355
  %183 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* nonnull %179, i32 61, i32 %180, i32 %181, i32 %182) #3, !dbg !575
  call void @llvm.lifetime.end.p0i8(i64 61, i8* nonnull %179) #3, !dbg !576
  br label %184, !dbg !577

184:                                              ; preds = %168, %174
  %185 = getelementptr inbounds i8, i8* %169, i64 4, !dbg !578
  %186 = bitcast i8* %185 to i32*, !dbg !578
  %187 = load i32, i32* %186, align 4, !dbg !578, !tbaa !579
  %188 = lshr i32 %187, 16, !dbg !580
  call void @llvm.dbg.value(metadata i32 %188, metadata !285, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 16, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !293
  %189 = getelementptr inbounds i8, i8* %23, i64 2, !dbg !581
  %190 = bitcast i8* %189 to i16*, !dbg !581
  %191 = load i16, i16* %190, align 2, !dbg !581, !tbaa !351
  %192 = zext i16 %191 to i32, !dbg !582
  %193 = icmp eq i32 %188, %192, !dbg !583
  br i1 %193, label %201, label %194, !dbg !584

194:                                              ; preds = %184
  %195 = getelementptr inbounds [40 x i8], [40 x i8]* %10, i64 0, i64 0, !dbg !585
  call void @llvm.lifetime.start.p0i8(i64 40, i8* nonnull %195) #3, !dbg !585
  call void @llvm.dbg.declare(metadata [40 x i8]* %10, metadata !286, metadata !DIExpression()), !dbg !585
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(40) %195, i8* nonnull align 1 dereferenceable(40) getelementptr inbounds ([40 x i8], [40 x i8]* @__const.tc_iphash_to_cpu.____fmt.5, i64 0, i64 0), i64 40, i1 false), !dbg !585
  %196 = load i16, i16* %190, align 2, !dbg !585, !tbaa !351
  %197 = zext i16 %196 to i32, !dbg !585
  %198 = load i32, i32* %186, align 4, !dbg !585, !tbaa !579
  %199 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* nonnull %195, i32 40, i32 %197, i32 %198) #3, !dbg !585
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %195) #3, !dbg !586
  %200 = load i32, i32* %186, align 4, !dbg !587, !tbaa !579
  br label %201, !dbg !589

201:                                              ; preds = %184, %194
  %202 = phi i32 [ %187, %184 ], [ %200, %194 ], !dbg !587
  %203 = icmp eq i32 %202, 0, !dbg !590
  br i1 %203, label %205, label %204, !dbg !591

204:                                              ; preds = %201
  store i32 %202, i32* %55, align 8, !dbg !592, !tbaa !355
  br label %205, !dbg !593

205:                                              ; preds = %62, %204, %201, %108, %100, %1, %162, %97, %42
  %206 = phi i32 [ 0, %42 ], [ 0, %162 ], [ 0, %97 ], [ 2, %1 ], [ 0, %62 ], [ 0, %100 ], [ 0, %108 ], [ 0, %201 ], [ 0, %204 ], !dbg !293
  call void @llvm.lifetime.end.p0i8(i64 20, i8* nonnull %22) #3, !dbg !594
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %13) #3, !dbg !594
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %11) #3, !dbg !594
  ret i32 %206, !dbg !594
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: nounwind readnone speculatable willreturn
declare i16 @llvm.bswap.i16(i16) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #2

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nounwind willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!130, !131, !132}
!llvm.ident = !{!133}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "map_txq_config", scope: !2, file: !3, line: 31, type: !114, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !11, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "tc_classify_kern.c", directory: "/home/asteria/xdp/xdp_cpumap_tc/src")
!4 = !{}
!5 = !{!6, !7, !8}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!7 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!8 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !9, line: 24, baseType: !10)
!9 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!10 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!11 = !{!12, !18, !76, !0, !94, !100, !107}
!12 = !DIGlobalVariableExpression(var: !13, expr: !DIExpression())
!13 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 409, type: !14, isLocal: false, isDefinition: true)
!14 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 32, elements: !16)
!15 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!16 = !{!17}
!17 = !DISubrange(count: 4)
!18 = !DIGlobalVariableExpression(var: !19, expr: !DIExpression())
!19 = distinct !DIGlobalVariable(name: "map_ip_hash", scope: !2, file: !20, line: 16, type: !21, isLocal: false, isDefinition: true)
!20 = !DIFile(filename: "./shared_maps.h", directory: "/home/asteria/xdp/xdp_cpumap_tc/src")
!21 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !20, line: 9, size: 384, elements: !22)
!22 = !{!23, !29, !34, !64, !70, !75}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !21, file: !20, line: 10, baseType: !24, size: 64)
!24 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!25 = !DICompositeType(tag: DW_TAG_array_type, baseType: !26, size: 352, elements: !27)
!26 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!27 = !{!28}
!28 = !DISubrange(count: 11)
!29 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !21, file: !20, line: 11, baseType: !30, size: 64, offset: 64)
!30 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !31, size: 64)
!31 = !DICompositeType(tag: DW_TAG_array_type, baseType: !26, size: 1048544, elements: !32)
!32 = !{!33}
!33 = !DISubrange(count: 32767)
!34 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !21, file: !20, line: 12, baseType: !35, size: 64, offset: 128)
!35 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !36, size: 64)
!36 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ip_hash_key", file: !37, line: 38, size: 160, elements: !38)
!37 = !DIFile(filename: "./common_kern_user.h", directory: "/home/asteria/xdp/xdp_cpumap_tc/src")
!38 = !{!39, !42}
!39 = !DIDerivedType(tag: DW_TAG_member, name: "prefixlen", scope: !36, file: !37, line: 39, baseType: !40, size: 32)
!40 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !9, line: 27, baseType: !41)
!41 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!42 = !DIDerivedType(tag: DW_TAG_member, name: "address", scope: !36, file: !37, line: 40, baseType: !43, size: 128, offset: 32)
!43 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "in6_addr", file: !44, line: 33, size: 128, elements: !45)
!44 = !DIFile(filename: "/usr/include/linux/in6.h", directory: "")
!45 = !{!46}
!46 = !DIDerivedType(tag: DW_TAG_member, name: "in6_u", scope: !43, file: !44, line: 40, baseType: !47, size: 128)
!47 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !43, file: !44, line: 34, size: 128, elements: !48)
!48 = !{!49, !55, !61}
!49 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr8", scope: !47, file: !44, line: 35, baseType: !50, size: 128)
!50 = !DICompositeType(tag: DW_TAG_array_type, baseType: !51, size: 128, elements: !53)
!51 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !9, line: 21, baseType: !52)
!52 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!53 = !{!54}
!54 = !DISubrange(count: 16)
!55 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr16", scope: !47, file: !44, line: 37, baseType: !56, size: 128)
!56 = !DICompositeType(tag: DW_TAG_array_type, baseType: !57, size: 128, elements: !59)
!57 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !58, line: 25, baseType: !8)
!58 = !DIFile(filename: "/usr/include/linux/types.h", directory: "")
!59 = !{!60}
!60 = !DISubrange(count: 8)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr32", scope: !47, file: !44, line: 38, baseType: !62, size: 128)
!62 = !DICompositeType(tag: DW_TAG_array_type, baseType: !63, size: 128, elements: !16)
!63 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !58, line: 27, baseType: !40)
!64 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !21, file: !20, line: 13, baseType: !65, size: 64, offset: 192)
!65 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !66, size: 64)
!66 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ip_hash_info", file: !37, line: 31, size: 64, elements: !67)
!67 = !{!68, !69}
!68 = !DIDerivedType(tag: DW_TAG_member, name: "cpu", scope: !66, file: !37, line: 33, baseType: !40, size: 32)
!69 = !DIDerivedType(tag: DW_TAG_member, name: "tc_handle", scope: !66, file: !37, line: 34, baseType: !40, size: 32, offset: 32)
!70 = !DIDerivedType(tag: DW_TAG_member, name: "pinning", scope: !21, file: !20, line: 14, baseType: !71, size: 64, offset: 256)
!71 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !72, size: 64)
!72 = !DICompositeType(tag: DW_TAG_array_type, baseType: !26, size: 32, elements: !73)
!73 = !{!74}
!74 = !DISubrange(count: 1)
!75 = !DIDerivedType(tag: DW_TAG_member, name: "map_flags", scope: !21, file: !20, line: 15, baseType: !71, size: 64, offset: 320)
!76 = !DIGlobalVariableExpression(var: !77, expr: !DIExpression())
!77 = distinct !DIGlobalVariable(name: "map_ifindex_type", scope: !2, file: !20, line: 25, type: !78, isLocal: false, isDefinition: true)
!78 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !20, line: 19, size: 320, elements: !79)
!79 = !{!80, !85, !90, !92, !93}
!80 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !78, file: !20, line: 20, baseType: !81, size: 64)
!81 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !82, size: 64)
!82 = !DICompositeType(tag: DW_TAG_array_type, baseType: !26, size: 64, elements: !83)
!83 = !{!84}
!84 = !DISubrange(count: 2)
!85 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !78, file: !20, line: 21, baseType: !86, size: 64, offset: 64)
!86 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !87, size: 64)
!87 = !DICompositeType(tag: DW_TAG_array_type, baseType: !26, size: 8192, elements: !88)
!88 = !{!89}
!89 = !DISubrange(count: 256)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !78, file: !20, line: 22, baseType: !91, size: 64, offset: 128)
!91 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !40, size: 64)
!92 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !78, file: !20, line: 23, baseType: !91, size: 64, offset: 192)
!93 = !DIDerivedType(tag: DW_TAG_member, name: "pinning", scope: !78, file: !20, line: 24, baseType: !71, size: 64, offset: 256)
!94 = !DIGlobalVariableExpression(var: !95, expr: !DIExpression())
!95 = distinct !DIGlobalVariable(name: "bpf_get_smp_processor_id", scope: !2, file: !96, line: 206, type: !97, isLocal: true, isDefinition: true)
!96 = !DIFile(filename: "../libbpf/src/../../libbpf-install/usr/include/bpf/bpf_helper_defs.h", directory: "/home/asteria/xdp/xdp_cpumap_tc/src")
!97 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !98, size: 64)
!98 = !DISubroutineType(types: !99)
!99 = !{!40}
!100 = !DIGlobalVariableExpression(var: !101, expr: !DIExpression())
!101 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !96, line: 56, type: !102, isLocal: true, isDefinition: true)
!102 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !103, size: 64)
!103 = !DISubroutineType(types: !104)
!104 = !{!6, !6, !105}
!105 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !106, size: 64)
!106 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!107 = !DIGlobalVariableExpression(var: !108, expr: !DIExpression())
!108 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !96, line: 177, type: !109, isLocal: true, isDefinition: true)
!109 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !110, size: 64)
!110 = !DISubroutineType(types: !111)
!111 = !{!7, !112, !40, null}
!112 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !113, size: 64)
!113 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !15)
!114 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 25, size: 320, elements: !115)
!115 = !{!116, !117, !122, !123, !129}
!116 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !114, file: !3, line: 26, baseType: !81, size: 64)
!117 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !114, file: !3, line: 27, baseType: !118, size: 64, offset: 64)
!118 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !119, size: 64)
!119 = !DICompositeType(tag: DW_TAG_array_type, baseType: !26, size: 2048, elements: !120)
!120 = !{!121}
!121 = !DISubrange(count: 64)
!122 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !114, file: !3, line: 28, baseType: !91, size: 64, offset: 128)
!123 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !114, file: !3, line: 29, baseType: !124, size: 64, offset: 192)
!124 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !125, size: 64)
!125 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "txq_config", file: !37, line: 23, size: 32, elements: !126)
!126 = !{!127, !128}
!127 = !DIDerivedType(tag: DW_TAG_member, name: "queue_mapping", scope: !125, file: !37, line: 25, baseType: !8, size: 16)
!128 = !DIDerivedType(tag: DW_TAG_member, name: "htb_major", scope: !125, file: !37, line: 26, baseType: !8, size: 16, offset: 16)
!129 = !DIDerivedType(tag: DW_TAG_member, name: "pinning", scope: !114, file: !3, line: 30, baseType: !71, size: 64, offset: 256)
!130 = !{i32 7, !"Dwarf Version", i32 4}
!131 = !{i32 2, !"Debug Info Version", i32 3}
!132 = !{i32 1, !"wchar_size", i32 4}
!133 = !{!"clang version 10.0.0-4ubuntu1 "}
!134 = distinct !DISubprogram(name: "tc_iphash_to_cpu", scope: !3, file: !3, line: 288, type: !135, scopeLine: 289, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !228)
!135 = !DISubroutineType(types: !136)
!136 = !{!26, !137}
!137 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !138, size: 64)
!138 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__sk_buff", file: !139, line: 2972, size: 1408, elements: !140)
!139 = !DIFile(filename: "/usr/include/linux/bpf.h", directory: "")
!140 = !{!141, !142, !143, !144, !145, !146, !147, !148, !149, !150, !151, !152, !153, !157, !158, !159, !160, !161, !162, !163, !164, !165, !167, !168, !169, !170, !171, !203, !206, !207, !208}
!141 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !138, file: !139, line: 2973, baseType: !40, size: 32)
!142 = !DIDerivedType(tag: DW_TAG_member, name: "pkt_type", scope: !138, file: !139, line: 2974, baseType: !40, size: 32, offset: 32)
!143 = !DIDerivedType(tag: DW_TAG_member, name: "mark", scope: !138, file: !139, line: 2975, baseType: !40, size: 32, offset: 64)
!144 = !DIDerivedType(tag: DW_TAG_member, name: "queue_mapping", scope: !138, file: !139, line: 2976, baseType: !40, size: 32, offset: 96)
!145 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !138, file: !139, line: 2977, baseType: !40, size: 32, offset: 128)
!146 = !DIDerivedType(tag: DW_TAG_member, name: "vlan_present", scope: !138, file: !139, line: 2978, baseType: !40, size: 32, offset: 160)
!147 = !DIDerivedType(tag: DW_TAG_member, name: "vlan_tci", scope: !138, file: !139, line: 2979, baseType: !40, size: 32, offset: 192)
!148 = !DIDerivedType(tag: DW_TAG_member, name: "vlan_proto", scope: !138, file: !139, line: 2980, baseType: !40, size: 32, offset: 224)
!149 = !DIDerivedType(tag: DW_TAG_member, name: "priority", scope: !138, file: !139, line: 2981, baseType: !40, size: 32, offset: 256)
!150 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !138, file: !139, line: 2982, baseType: !40, size: 32, offset: 288)
!151 = !DIDerivedType(tag: DW_TAG_member, name: "ifindex", scope: !138, file: !139, line: 2983, baseType: !40, size: 32, offset: 320)
!152 = !DIDerivedType(tag: DW_TAG_member, name: "tc_index", scope: !138, file: !139, line: 2984, baseType: !40, size: 32, offset: 352)
!153 = !DIDerivedType(tag: DW_TAG_member, name: "cb", scope: !138, file: !139, line: 2985, baseType: !154, size: 160, offset: 384)
!154 = !DICompositeType(tag: DW_TAG_array_type, baseType: !40, size: 160, elements: !155)
!155 = !{!156}
!156 = !DISubrange(count: 5)
!157 = !DIDerivedType(tag: DW_TAG_member, name: "hash", scope: !138, file: !139, line: 2986, baseType: !40, size: 32, offset: 544)
!158 = !DIDerivedType(tag: DW_TAG_member, name: "tc_classid", scope: !138, file: !139, line: 2987, baseType: !40, size: 32, offset: 576)
!159 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !138, file: !139, line: 2988, baseType: !40, size: 32, offset: 608)
!160 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !138, file: !139, line: 2989, baseType: !40, size: 32, offset: 640)
!161 = !DIDerivedType(tag: DW_TAG_member, name: "napi_id", scope: !138, file: !139, line: 2990, baseType: !40, size: 32, offset: 672)
!162 = !DIDerivedType(tag: DW_TAG_member, name: "family", scope: !138, file: !139, line: 2993, baseType: !40, size: 32, offset: 704)
!163 = !DIDerivedType(tag: DW_TAG_member, name: "remote_ip4", scope: !138, file: !139, line: 2994, baseType: !40, size: 32, offset: 736)
!164 = !DIDerivedType(tag: DW_TAG_member, name: "local_ip4", scope: !138, file: !139, line: 2995, baseType: !40, size: 32, offset: 768)
!165 = !DIDerivedType(tag: DW_TAG_member, name: "remote_ip6", scope: !138, file: !139, line: 2996, baseType: !166, size: 128, offset: 800)
!166 = !DICompositeType(tag: DW_TAG_array_type, baseType: !40, size: 128, elements: !16)
!167 = !DIDerivedType(tag: DW_TAG_member, name: "local_ip6", scope: !138, file: !139, line: 2997, baseType: !166, size: 128, offset: 928)
!168 = !DIDerivedType(tag: DW_TAG_member, name: "remote_port", scope: !138, file: !139, line: 2998, baseType: !40, size: 32, offset: 1056)
!169 = !DIDerivedType(tag: DW_TAG_member, name: "local_port", scope: !138, file: !139, line: 2999, baseType: !40, size: 32, offset: 1088)
!170 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !138, file: !139, line: 3002, baseType: !40, size: 32, offset: 1120)
!171 = !DIDerivedType(tag: DW_TAG_member, scope: !138, file: !139, line: 3003, baseType: !172, size: 64, align: 64, offset: 1152)
!172 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !138, file: !139, line: 3003, size: 64, align: 64, elements: !173)
!173 = !{!174}
!174 = !DIDerivedType(tag: DW_TAG_member, name: "flow_keys", scope: !172, file: !139, line: 3003, baseType: !175, size: 64)
!175 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !176, size: 64)
!176 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_flow_keys", file: !139, line: 3553, size: 448, elements: !177)
!177 = !{!178, !179, !180, !181, !182, !183, !184, !185, !186, !187, !188, !201, !202}
!178 = !DIDerivedType(tag: DW_TAG_member, name: "nhoff", scope: !176, file: !139, line: 3554, baseType: !8, size: 16)
!179 = !DIDerivedType(tag: DW_TAG_member, name: "thoff", scope: !176, file: !139, line: 3555, baseType: !8, size: 16, offset: 16)
!180 = !DIDerivedType(tag: DW_TAG_member, name: "addr_proto", scope: !176, file: !139, line: 3556, baseType: !8, size: 16, offset: 32)
!181 = !DIDerivedType(tag: DW_TAG_member, name: "is_frag", scope: !176, file: !139, line: 3557, baseType: !51, size: 8, offset: 48)
!182 = !DIDerivedType(tag: DW_TAG_member, name: "is_first_frag", scope: !176, file: !139, line: 3558, baseType: !51, size: 8, offset: 56)
!183 = !DIDerivedType(tag: DW_TAG_member, name: "is_encap", scope: !176, file: !139, line: 3559, baseType: !51, size: 8, offset: 64)
!184 = !DIDerivedType(tag: DW_TAG_member, name: "ip_proto", scope: !176, file: !139, line: 3560, baseType: !51, size: 8, offset: 72)
!185 = !DIDerivedType(tag: DW_TAG_member, name: "n_proto", scope: !176, file: !139, line: 3561, baseType: !57, size: 16, offset: 80)
!186 = !DIDerivedType(tag: DW_TAG_member, name: "sport", scope: !176, file: !139, line: 3562, baseType: !57, size: 16, offset: 96)
!187 = !DIDerivedType(tag: DW_TAG_member, name: "dport", scope: !176, file: !139, line: 3563, baseType: !57, size: 16, offset: 112)
!188 = !DIDerivedType(tag: DW_TAG_member, scope: !176, file: !139, line: 3564, baseType: !189, size: 256, offset: 128)
!189 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !176, file: !139, line: 3564, size: 256, elements: !190)
!190 = !{!191, !196}
!191 = !DIDerivedType(tag: DW_TAG_member, scope: !189, file: !139, line: 3565, baseType: !192, size: 64)
!192 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !189, file: !139, line: 3565, size: 64, elements: !193)
!193 = !{!194, !195}
!194 = !DIDerivedType(tag: DW_TAG_member, name: "ipv4_src", scope: !192, file: !139, line: 3566, baseType: !63, size: 32)
!195 = !DIDerivedType(tag: DW_TAG_member, name: "ipv4_dst", scope: !192, file: !139, line: 3567, baseType: !63, size: 32, offset: 32)
!196 = !DIDerivedType(tag: DW_TAG_member, scope: !189, file: !139, line: 3569, baseType: !197, size: 256)
!197 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !189, file: !139, line: 3569, size: 256, elements: !198)
!198 = !{!199, !200}
!199 = !DIDerivedType(tag: DW_TAG_member, name: "ipv6_src", scope: !197, file: !139, line: 3570, baseType: !166, size: 128)
!200 = !DIDerivedType(tag: DW_TAG_member, name: "ipv6_dst", scope: !197, file: !139, line: 3571, baseType: !166, size: 128, offset: 128)
!201 = !DIDerivedType(tag: DW_TAG_member, name: "flags", scope: !176, file: !139, line: 3574, baseType: !40, size: 32, offset: 384)
!202 = !DIDerivedType(tag: DW_TAG_member, name: "flow_label", scope: !176, file: !139, line: 3575, baseType: !63, size: 32, offset: 416)
!203 = !DIDerivedType(tag: DW_TAG_member, name: "tstamp", scope: !138, file: !139, line: 3004, baseType: !204, size: 64, offset: 1216)
!204 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !9, line: 31, baseType: !205)
!205 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!206 = !DIDerivedType(tag: DW_TAG_member, name: "wire_len", scope: !138, file: !139, line: 3005, baseType: !40, size: 32, offset: 1280)
!207 = !DIDerivedType(tag: DW_TAG_member, name: "gso_segs", scope: !138, file: !139, line: 3006, baseType: !40, size: 32, offset: 1312)
!208 = !DIDerivedType(tag: DW_TAG_member, scope: !138, file: !139, line: 3007, baseType: !209, size: 64, align: 64, offset: 1344)
!209 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !138, file: !139, line: 3007, size: 64, align: 64, elements: !210)
!210 = !{!211}
!211 = !DIDerivedType(tag: DW_TAG_member, name: "sk", scope: !209, file: !139, line: 3007, baseType: !212, size: 64)
!212 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !213, size: 64)
!213 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_sock", file: !139, line: 3060, size: 608, elements: !214)
!214 = !{!215, !216, !217, !218, !219, !220, !221, !222, !223, !224, !225, !226, !227}
!215 = !DIDerivedType(tag: DW_TAG_member, name: "bound_dev_if", scope: !213, file: !139, line: 3061, baseType: !40, size: 32)
!216 = !DIDerivedType(tag: DW_TAG_member, name: "family", scope: !213, file: !139, line: 3062, baseType: !40, size: 32, offset: 32)
!217 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !213, file: !139, line: 3063, baseType: !40, size: 32, offset: 64)
!218 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !213, file: !139, line: 3064, baseType: !40, size: 32, offset: 96)
!219 = !DIDerivedType(tag: DW_TAG_member, name: "mark", scope: !213, file: !139, line: 3065, baseType: !40, size: 32, offset: 128)
!220 = !DIDerivedType(tag: DW_TAG_member, name: "priority", scope: !213, file: !139, line: 3066, baseType: !40, size: 32, offset: 160)
!221 = !DIDerivedType(tag: DW_TAG_member, name: "src_ip4", scope: !213, file: !139, line: 3068, baseType: !40, size: 32, offset: 192)
!222 = !DIDerivedType(tag: DW_TAG_member, name: "src_ip6", scope: !213, file: !139, line: 3069, baseType: !166, size: 128, offset: 224)
!223 = !DIDerivedType(tag: DW_TAG_member, name: "src_port", scope: !213, file: !139, line: 3070, baseType: !40, size: 32, offset: 352)
!224 = !DIDerivedType(tag: DW_TAG_member, name: "dst_port", scope: !213, file: !139, line: 3071, baseType: !57, size: 16, offset: 384)
!225 = !DIDerivedType(tag: DW_TAG_member, name: "dst_ip4", scope: !213, file: !139, line: 3073, baseType: !40, size: 32, offset: 416)
!226 = !DIDerivedType(tag: DW_TAG_member, name: "dst_ip6", scope: !213, file: !139, line: 3074, baseType: !166, size: 128, offset: 448)
!227 = !DIDerivedType(tag: DW_TAG_member, name: "state", scope: !213, file: !139, line: 3075, baseType: !40, size: 32, offset: 576)
!228 = !{!229, !230, !231, !232, !233, !234, !235, !236, !237, !238, !249, !250, !251, !252, !259, !266, !273, !280, !285, !286}
!229 = !DILocalVariable(name: "skb", arg: 1, scope: !134, file: !3, line: 288, type: !137)
!230 = !DILocalVariable(name: "cpu", scope: !134, file: !3, line: 290, type: !40)
!231 = !DILocalVariable(name: "ip_info", scope: !134, file: !3, line: 291, type: !65)
!232 = !DILocalVariable(name: "txq_cfg", scope: !134, file: !3, line: 292, type: !124)
!233 = !DILocalVariable(name: "ifindex_type", scope: !134, file: !3, line: 293, type: !91)
!234 = !DILocalVariable(name: "ifindex", scope: !134, file: !3, line: 294, type: !40)
!235 = !DILocalVariable(name: "action", scope: !134, file: !3, line: 295, type: !40)
!236 = !DILocalVariable(name: "data_end", scope: !134, file: !3, line: 298, type: !6)
!237 = !DILocalVariable(name: "data", scope: !134, file: !3, line: 299, type: !6)
!238 = !DILocalVariable(name: "eth", scope: !134, file: !3, line: 300, type: !239)
!239 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !240, size: 64)
!240 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !241, line: 163, size: 112, elements: !242)
!241 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "")
!242 = !{!243, !247, !248}
!243 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !240, file: !241, line: 164, baseType: !244, size: 48)
!244 = !DICompositeType(tag: DW_TAG_array_type, baseType: !52, size: 48, elements: !245)
!245 = !{!246}
!246 = !DISubrange(count: 6)
!247 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !240, file: !241, line: 165, baseType: !244, size: 48, offset: 48)
!248 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !240, file: !241, line: 166, baseType: !57, size: 16, offset: 96)
!249 = !DILocalVariable(name: "eth_proto", scope: !134, file: !3, line: 301, type: !8)
!250 = !DILocalVariable(name: "l3_offset", scope: !134, file: !3, line: 302, type: !40)
!251 = !DILocalVariable(name: "hash_key", scope: !134, file: !3, line: 304, type: !36)
!252 = !DILocalVariable(name: "____fmt", scope: !253, file: !3, line: 313, type: !256)
!253 = distinct !DILexicalBlock(scope: !254, file: !3, line: 313, column: 3)
!254 = distinct !DILexicalBlock(scope: !255, file: !3, line: 312, column: 9)
!255 = distinct !DILexicalBlock(scope: !134, file: !3, line: 310, column: 6)
!256 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 344, elements: !257)
!257 = !{!258}
!258 = !DISubrange(count: 43)
!259 = !DILocalVariable(name: "____fmt", scope: !260, file: !3, line: 333, type: !263)
!260 = distinct !DILexicalBlock(scope: !261, file: !3, line: 333, column: 3)
!261 = distinct !DILexicalBlock(scope: !262, file: !3, line: 332, column: 59)
!262 = distinct !DILexicalBlock(scope: !134, file: !3, line: 332, column: 6)
!263 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 360, elements: !264)
!264 = !{!265}
!265 = !DISubrange(count: 45)
!266 = !DILocalVariable(name: "____fmt", scope: !267, file: !3, line: 372, type: !272)
!267 = distinct !DILexicalBlock(scope: !268, file: !3, line: 372, column: 4)
!268 = distinct !DILexicalBlock(scope: !269, file: !3, line: 371, column: 17)
!269 = distinct !DILexicalBlock(scope: !270, file: !3, line: 371, column: 7)
!270 = distinct !DILexicalBlock(scope: !271, file: !3, line: 366, column: 16)
!271 = distinct !DILexicalBlock(scope: !134, file: !3, line: 366, column: 6)
!272 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 512, elements: !120)
!273 = !DILocalVariable(name: "____fmt", scope: !274, file: !3, line: 380, type: !277)
!274 = distinct !DILexicalBlock(scope: !275, file: !3, line: 380, column: 3)
!275 = distinct !DILexicalBlock(scope: !276, file: !3, line: 379, column: 27)
!276 = distinct !DILexicalBlock(scope: !134, file: !3, line: 379, column: 6)
!277 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 408, elements: !278)
!278 = !{!279}
!279 = !DISubrange(count: 51)
!280 = !DILocalVariable(name: "____fmt", scope: !281, file: !3, line: 382, type: !282)
!281 = distinct !DILexicalBlock(scope: !275, file: !3, line: 382, column: 3)
!282 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 488, elements: !283)
!283 = !{!284}
!284 = !DISubrange(count: 61)
!285 = !DILocalVariable(name: "ip_info_major", scope: !134, file: !3, line: 390, type: !8)
!286 = !DILocalVariable(name: "____fmt", scope: !287, file: !3, line: 394, type: !290)
!287 = distinct !DILexicalBlock(scope: !288, file: !3, line: 394, column: 3)
!288 = distinct !DILexicalBlock(scope: !289, file: !3, line: 392, column: 2)
!289 = distinct !DILexicalBlock(scope: !134, file: !3, line: 391, column: 6)
!290 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 320, elements: !291)
!291 = !{!292}
!292 = !DISubrange(count: 40)
!293 = !DILocation(line: 0, scope: !134)
!294 = !DILocation(line: 290, column: 2, scope: !134)
!295 = !DILocation(line: 290, column: 14, scope: !134)
!296 = !DILocation(line: 290, column: 8, scope: !134)
!297 = !{!298, !298, i64 0}
!298 = !{!"int", !299, i64 0}
!299 = !{!"omnipotent char", !300, i64 0}
!300 = !{!"Simple C/C++ TBAA"}
!301 = !DILocation(line: 294, column: 2, scope: !134)
!302 = !DILocation(line: 298, column: 38, scope: !134)
!303 = !{!304, !298, i64 80}
!304 = !{!"__sk_buff", !298, i64 0, !298, i64 4, !298, i64 8, !298, i64 12, !298, i64 16, !298, i64 20, !298, i64 24, !298, i64 28, !298, i64 32, !298, i64 36, !298, i64 40, !298, i64 44, !299, i64 48, !298, i64 68, !298, i64 72, !298, i64 76, !298, i64 80, !298, i64 84, !298, i64 88, !298, i64 92, !298, i64 96, !299, i64 100, !299, i64 116, !298, i64 132, !298, i64 136, !298, i64 140, !299, i64 144, !305, i64 152, !298, i64 160, !298, i64 164, !299, i64 168}
!305 = !{!"long long", !299, i64 0}
!306 = !DILocation(line: 298, column: 27, scope: !134)
!307 = !DILocation(line: 298, column: 19, scope: !134)
!308 = !DILocation(line: 299, column: 38, scope: !134)
!309 = !{!304, !298, i64 76}
!310 = !DILocation(line: 299, column: 27, scope: !134)
!311 = !DILocation(line: 300, column: 23, scope: !134)
!312 = !DILocation(line: 304, column: 2, scope: !134)
!313 = !DILocation(line: 304, column: 21, scope: !134)
!314 = !DILocation(line: 306, column: 12, scope: !134)
!315 = !DILocation(line: 307, column: 14, scope: !316)
!316 = distinct !DILexicalBlock(scope: !134, file: !3, line: 307, column: 13)
!317 = !DILocation(line: 307, column: 13, scope: !134)
!318 = !DILocation(line: 310, column: 15, scope: !255)
!319 = !{!320, !321, i64 0}
!320 = !{!"txq_config", !321, i64 0, !321, i64 2}
!321 = !{!"short", !299, i64 0}
!322 = !DILocation(line: 310, column: 29, scope: !255)
!323 = !DILocation(line: 310, column: 6, scope: !134)
!324 = !DILocation(line: 310, column: 6, scope: !255)
!325 = !DILocation(line: 311, column: 8, scope: !326)
!326 = distinct !DILexicalBlock(scope: !255, file: !3, line: 310, column: 35)
!327 = !DILocation(line: 311, column: 22, scope: !326)
!328 = !{!304, !298, i64 12}
!329 = !DILocation(line: 312, column: 2, scope: !326)
!330 = !DILocation(line: 313, column: 3, scope: !253)
!331 = !DILocation(line: 313, column: 3, scope: !254)
!332 = !DILocation(line: 318, column: 11, scope: !333)
!333 = distinct !DILexicalBlock(scope: !134, file: !3, line: 318, column: 6)
!334 = !{!304, !298, i64 36}
!335 = !DILocation(line: 318, column: 27, scope: !333)
!336 = !DILocation(line: 318, column: 6, scope: !134)
!337 = !DILocalVariable(name: "skb", arg: 1, scope: !338, file: !3, line: 221, type: !137)
!338 = distinct !DISubprogram(name: "localhost_default_classid", scope: !3, file: !3, line: 221, type: !339, scopeLine: 223, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !341)
!339 = !DISubroutineType(types: !340)
!340 = !{!40, !137, !124}
!341 = !{!337, !342, !343, !344}
!342 = !DILocalVariable(name: "txq_cfg", arg: 2, scope: !338, file: !3, line: 222, type: !124)
!343 = !DILocalVariable(name: "cpu_major", scope: !338, file: !3, line: 224, type: !40)
!344 = !DILocalVariable(name: "curr_minor", scope: !345, file: !3, line: 237, type: !40)
!345 = distinct !DILexicalBlock(scope: !346, file: !3, line: 233, column: 9)
!346 = distinct !DILexicalBlock(scope: !338, file: !3, line: 231, column: 6)
!347 = !DILocation(line: 0, scope: !338, inlinedAt: !348)
!348 = distinct !DILocation(line: 319, column: 10, scope: !349)
!349 = distinct !DILexicalBlock(scope: !333, file: !3, line: 318, column: 33)
!350 = !DILocation(line: 229, column: 23, scope: !338, inlinedAt: !348)
!351 = !{!320, !321, i64 2}
!352 = !DILocation(line: 229, column: 14, scope: !338, inlinedAt: !348)
!353 = !DILocation(line: 229, column: 33, scope: !338, inlinedAt: !348)
!354 = !DILocation(line: 231, column: 11, scope: !346, inlinedAt: !348)
!355 = !{!304, !298, i64 32}
!356 = !DILocation(line: 231, column: 20, scope: !346, inlinedAt: !348)
!357 = !DILocation(line: 231, column: 6, scope: !338, inlinedAt: !348)
!358 = !DILocation(line: 0, scope: !346, inlinedAt: !348)
!359 = !DILocation(line: 319, column: 3, scope: !349)
!360 = !DILocalVariable(name: "skb", arg: 1, scope: !361, file: !3, line: 257, type: !137)
!361 = distinct !DISubprogram(name: "special_minor_classid", scope: !3, file: !3, line: 257, type: !362, scopeLine: 259, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !365)
!362 = !DISubroutineType(types: !363)
!363 = !{!364, !137, !124}
!364 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!365 = !{!360, !366, !367, !368}
!366 = !DILocalVariable(name: "txq_cfg", arg: 2, scope: !361, file: !3, line: 258, type: !124)
!367 = !DILocalVariable(name: "curr_minor", scope: !361, file: !3, line: 260, type: !40)
!368 = !DILocalVariable(name: "cpu_major", scope: !369, file: !3, line: 276, type: !40)
!369 = distinct !DILexicalBlock(scope: !370, file: !3, line: 271, column: 48)
!370 = distinct !DILexicalBlock(scope: !361, file: !3, line: 270, column: 6)
!371 = !DILocation(line: 0, scope: !361, inlinedAt: !372)
!372 = distinct !DILocation(line: 322, column: 6, scope: !373)
!373 = distinct !DILexicalBlock(scope: !134, file: !3, line: 322, column: 6)
!374 = !DILocation(line: 265, column: 11, scope: !375, inlinedAt: !372)
!375 = distinct !DILexicalBlock(scope: !361, file: !3, line: 265, column: 6)
!376 = !DILocation(line: 265, column: 20, scope: !375, inlinedAt: !372)
!377 = !DILocation(line: 265, column: 6, scope: !361, inlinedAt: !372)
!378 = !DILocation(line: 268, column: 15, scope: !361, inlinedAt: !372)
!379 = !DILocation(line: 270, column: 46, scope: !370, inlinedAt: !372)
!380 = !DILocation(line: 276, column: 31, scope: !369, inlinedAt: !372)
!381 = !DILocation(line: 276, column: 22, scope: !369, inlinedAt: !372)
!382 = !DILocation(line: 276, column: 41, scope: !369, inlinedAt: !372)
!383 = !DILocation(line: 0, scope: !369, inlinedAt: !372)
!384 = !DILocation(line: 278, column: 29, scope: !369, inlinedAt: !372)
!385 = !DILocation(line: 278, column: 17, scope: !369, inlinedAt: !372)
!386 = !DILocation(line: 322, column: 6, scope: !134)
!387 = !DILocalVariable(name: "eth", arg: 1, scope: !388, file: !3, line: 113, type: !239)
!388 = distinct !DISubprogram(name: "parse_eth", scope: !3, file: !3, line: 113, type: !389, scopeLine: 115, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !392)
!389 = !DISubroutineType(types: !390)
!390 = !{!364, !239, !6, !391, !91}
!391 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!392 = !{!387, !393, !394, !395, !396, !397, !398, !406}
!393 = !DILocalVariable(name: "data_end", arg: 2, scope: !388, file: !3, line: 113, type: !6)
!394 = !DILocalVariable(name: "eth_proto", arg: 3, scope: !388, file: !3, line: 114, type: !391)
!395 = !DILocalVariable(name: "l3_offset", arg: 4, scope: !388, file: !3, line: 114, type: !91)
!396 = !DILocalVariable(name: "eth_type", scope: !388, file: !3, line: 116, type: !8)
!397 = !DILocalVariable(name: "offset", scope: !388, file: !3, line: 117, type: !204)
!398 = !DILocalVariable(name: "vlan_hdr", scope: !399, file: !3, line: 132, type: !401)
!399 = distinct !DILexicalBlock(scope: !400, file: !3, line: 131, column: 43)
!400 = distinct !DILexicalBlock(scope: !388, file: !3, line: 130, column: 6)
!401 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !402, size: 64)
!402 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vlan_hdr", file: !3, line: 42, size: 32, elements: !403)
!403 = !{!404, !405}
!404 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_TCI", scope: !402, file: !3, line: 43, baseType: !57, size: 16)
!405 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_encapsulated_proto", scope: !402, file: !3, line: 44, baseType: !57, size: 16, offset: 16)
!406 = !DILocalVariable(name: "vlan_hdr", scope: !407, file: !3, line: 143, type: !401)
!407 = distinct !DILexicalBlock(scope: !408, file: !3, line: 142, column: 43)
!408 = distinct !DILexicalBlock(scope: !388, file: !3, line: 141, column: 6)
!409 = !DILocation(line: 0, scope: !388, inlinedAt: !410)
!410 = distinct !DILocation(line: 332, column: 8, scope: !262)
!411 = !DILocation(line: 120, column: 18, scope: !412, inlinedAt: !410)
!412 = distinct !DILexicalBlock(scope: !388, file: !3, line: 120, column: 6)
!413 = !DILocation(line: 120, column: 27, scope: !412, inlinedAt: !410)
!414 = !DILocation(line: 120, column: 6, scope: !388, inlinedAt: !410)
!415 = !DILocation(line: 123, column: 18, scope: !388, inlinedAt: !410)
!416 = !{!417, !321, i64 12}
!417 = !{!"ethhdr", !299, i64 0, !299, i64 6, !321, i64 12}
!418 = !DILocation(line: 126, column: 26, scope: !419, inlinedAt: !410)
!419 = distinct !DILexicalBlock(scope: !388, file: !3, line: 126, column: 6)
!420 = !DILocation(line: 126, column: 6, scope: !388, inlinedAt: !410)
!421 = !DILocation(line: 130, column: 41, scope: !400, inlinedAt: !410)
!422 = !DILocation(line: 0, scope: !399, inlinedAt: !410)
!423 = !DILocation(line: 136, column: 19, scope: !424, inlinedAt: !410)
!424 = distinct !DILexicalBlock(scope: !399, file: !3, line: 136, column: 7)
!425 = !DILocation(line: 136, column: 28, scope: !424, inlinedAt: !410)
!426 = !DILocation(line: 136, column: 7, scope: !399, inlinedAt: !410)
!427 = !DILocation(line: 138, column: 24, scope: !399, inlinedAt: !410)
!428 = !{!429, !321, i64 2}
!429 = !{!"vlan_hdr", !321, i64 0, !321, i64 2}
!430 = !DILocation(line: 123, column: 11, scope: !388, inlinedAt: !410)
!431 = !DILocation(line: 141, column: 41, scope: !408, inlinedAt: !410)
!432 = !DILocation(line: 0, scope: !407, inlinedAt: !410)
!433 = !DILocation(line: 146, column: 10, scope: !407, inlinedAt: !410)
!434 = !DILocation(line: 147, column: 19, scope: !435, inlinedAt: !410)
!435 = distinct !DILexicalBlock(scope: !407, file: !3, line: 147, column: 7)
!436 = !DILocation(line: 147, column: 28, scope: !435, inlinedAt: !410)
!437 = !DILocation(line: 147, column: 7, scope: !407, inlinedAt: !410)
!438 = !DILocation(line: 145, column: 26, scope: !407, inlinedAt: !410)
!439 = !DILocation(line: 149, column: 24, scope: !407, inlinedAt: !410)
!440 = !DILocation(line: 333, column: 3, scope: !260)
!441 = !DILocation(line: 333, column: 3, scope: !261)
!442 = !DILocation(line: 335, column: 3, scope: !261)
!443 = !DILocation(line: 339, column: 17, scope: !134)
!444 = !{!304, !298, i64 40}
!445 = !DILocation(line: 339, column: 10, scope: !134)
!446 = !DILocation(line: 340, column: 17, scope: !134)
!447 = !DILocation(line: 341, column: 7, scope: !448)
!448 = distinct !DILexicalBlock(scope: !134, file: !3, line: 341, column: 6)
!449 = !DILocation(line: 341, column: 6, scope: !134)
!450 = !DILocation(line: 345, column: 18, scope: !134)
!451 = !DILocation(line: 345, column: 28, scope: !134)
!452 = !{!453, !298, i64 0}
!453 = !{!"ip_hash_key", !298, i64 0, !454, i64 4}
!454 = !{!"in6_addr", !299, i64 0}
!455 = !DILocation(line: 346, column: 9, scope: !134)
!456 = !DILocation(line: 349, column: 9, scope: !134)
!457 = !DILocation(line: 350, column: 2, scope: !134)
!458 = !DILocation(line: 347, column: 45, scope: !134)
!459 = !DILocalVariable(name: "skb", arg: 1, scope: !460, file: !3, line: 158, type: !137)
!460 = distinct !DISubprogram(name: "get_ipv4_addr", scope: !3, file: !3, line: 158, type: !461, scopeLine: 160, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !463)
!461 = !DISubroutineType(types: !462)
!462 = !{null, !137, !40, !40, !35}
!463 = !{!459, !464, !465, !466, !467, !468, !469, !486}
!464 = !DILocalVariable(name: "l3_offset", arg: 2, scope: !460, file: !3, line: 158, type: !40)
!465 = !DILocalVariable(name: "ifindex_type", arg: 3, scope: !460, file: !3, line: 158, type: !40)
!466 = !DILocalVariable(name: "key", arg: 4, scope: !460, file: !3, line: 159, type: !35)
!467 = !DILocalVariable(name: "data_end", scope: !460, file: !3, line: 161, type: !6)
!468 = !DILocalVariable(name: "data", scope: !460, file: !3, line: 162, type: !6)
!469 = !DILocalVariable(name: "iph", scope: !460, file: !3, line: 163, type: !470)
!470 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !471, size: 64)
!471 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !472, line: 86, size: 160, elements: !473)
!472 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "")
!473 = !{!474, !475, !476, !477, !478, !479, !480, !481, !482, !484, !485}
!474 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !471, file: !472, line: 88, baseType: !51, size: 4, flags: DIFlagBitField, extraData: i64 0)
!475 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !471, file: !472, line: 89, baseType: !51, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!476 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !471, file: !472, line: 96, baseType: !51, size: 8, offset: 8)
!477 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !471, file: !472, line: 97, baseType: !57, size: 16, offset: 16)
!478 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !471, file: !472, line: 98, baseType: !57, size: 16, offset: 32)
!479 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !471, file: !472, line: 99, baseType: !57, size: 16, offset: 48)
!480 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !471, file: !472, line: 100, baseType: !51, size: 8, offset: 64)
!481 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !471, file: !472, line: 101, baseType: !51, size: 8, offset: 72)
!482 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !471, file: !472, line: 102, baseType: !483, size: 16, offset: 80)
!483 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !58, line: 31, baseType: !8)
!484 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !471, file: !472, line: 103, baseType: !63, size: 32, offset: 96)
!485 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !471, file: !472, line: 104, baseType: !63, size: 32, offset: 128)
!486 = !DILocalVariable(name: "ipv4", scope: !460, file: !3, line: 164, type: !40)
!487 = !DILocation(line: 0, scope: !460, inlinedAt: !488)
!488 = distinct !DILocation(line: 352, column: 3, scope: !489)
!489 = distinct !DILexicalBlock(scope: !134, file: !3, line: 350, column: 21)
!490 = !DILocation(line: 161, column: 38, scope: !460, inlinedAt: !488)
!491 = !DILocation(line: 161, column: 27, scope: !460, inlinedAt: !488)
!492 = !DILocation(line: 162, column: 38, scope: !460, inlinedAt: !488)
!493 = !DILocation(line: 162, column: 27, scope: !460, inlinedAt: !488)
!494 = !DILocation(line: 162, column: 19, scope: !460, inlinedAt: !488)
!495 = !DILocation(line: 163, column: 27, scope: !460, inlinedAt: !488)
!496 = !DILocation(line: 166, column: 10, scope: !497, inlinedAt: !488)
!497 = distinct !DILexicalBlock(scope: !460, file: !3, line: 166, column: 6)
!498 = !DILocation(line: 166, column: 16, scope: !497, inlinedAt: !488)
!499 = !DILocation(line: 166, column: 14, scope: !497, inlinedAt: !488)
!500 = !DILocation(line: 166, column: 6, scope: !460, inlinedAt: !488)
!501 = !DILocation(line: 352, column: 33, scope: !489)
!502 = !DILocation(line: 174, column: 2, scope: !460, inlinedAt: !488)
!503 = !DILocation(line: 180, column: 3, scope: !504, inlinedAt: !488)
!504 = distinct !DILexicalBlock(scope: !460, file: !3, line: 174, column: 24)
!505 = !DILocation(line: 0, scope: !504, inlinedAt: !488)
!506 = !DILocation(line: 184, column: 34, scope: !460, inlinedAt: !488)
!507 = !{!299, !299, i64 0}
!508 = !DILocation(line: 185, column: 1, scope: !460, inlinedAt: !488)
!509 = !DILocalVariable(name: "skb", arg: 1, scope: !510, file: !3, line: 189, type: !137)
!510 = distinct !DISubprogram(name: "get_ipv6_addr", scope: !3, file: !3, line: 189, type: !461, scopeLine: 191, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !511)
!511 = !{!509, !512, !513, !514, !515, !516, !517}
!512 = !DILocalVariable(name: "l3_offset", arg: 2, scope: !510, file: !3, line: 189, type: !40)
!513 = !DILocalVariable(name: "ifindex_type", arg: 3, scope: !510, file: !3, line: 189, type: !40)
!514 = !DILocalVariable(name: "key", arg: 4, scope: !510, file: !3, line: 190, type: !35)
!515 = !DILocalVariable(name: "data_end", scope: !510, file: !3, line: 192, type: !6)
!516 = !DILocalVariable(name: "data", scope: !510, file: !3, line: 193, type: !6)
!517 = !DILocalVariable(name: "ip6h", scope: !510, file: !3, line: 194, type: !518)
!518 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !519, size: 64)
!519 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ipv6hdr", file: !520, line: 116, size: 320, elements: !521)
!520 = !DIFile(filename: "/usr/include/linux/ipv6.h", directory: "")
!521 = !{!522, !523, !524, !528, !529, !530, !531, !532}
!522 = !DIDerivedType(tag: DW_TAG_member, name: "priority", scope: !519, file: !520, line: 118, baseType: !51, size: 4, flags: DIFlagBitField, extraData: i64 0)
!523 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !519, file: !520, line: 119, baseType: !51, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!524 = !DIDerivedType(tag: DW_TAG_member, name: "flow_lbl", scope: !519, file: !520, line: 126, baseType: !525, size: 24, offset: 8)
!525 = !DICompositeType(tag: DW_TAG_array_type, baseType: !51, size: 24, elements: !526)
!526 = !{!527}
!527 = !DISubrange(count: 3)
!528 = !DIDerivedType(tag: DW_TAG_member, name: "payload_len", scope: !519, file: !520, line: 128, baseType: !57, size: 16, offset: 32)
!529 = !DIDerivedType(tag: DW_TAG_member, name: "nexthdr", scope: !519, file: !520, line: 129, baseType: !51, size: 8, offset: 48)
!530 = !DIDerivedType(tag: DW_TAG_member, name: "hop_limit", scope: !519, file: !520, line: 130, baseType: !51, size: 8, offset: 56)
!531 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !519, file: !520, line: 132, baseType: !43, size: 128, offset: 64)
!532 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !519, file: !520, line: 133, baseType: !43, size: 128, offset: 192)
!533 = !DILocation(line: 0, scope: !510, inlinedAt: !534)
!534 = distinct !DILocation(line: 355, column: 3, scope: !489)
!535 = !DILocation(line: 192, column: 38, scope: !510, inlinedAt: !534)
!536 = !DILocation(line: 192, column: 27, scope: !510, inlinedAt: !534)
!537 = !DILocation(line: 193, column: 38, scope: !510, inlinedAt: !534)
!538 = !DILocation(line: 193, column: 27, scope: !510, inlinedAt: !534)
!539 = !DILocation(line: 193, column: 19, scope: !510, inlinedAt: !534)
!540 = !DILocation(line: 194, column: 30, scope: !510, inlinedAt: !534)
!541 = !DILocation(line: 196, column: 11, scope: !542, inlinedAt: !534)
!542 = distinct !DILexicalBlock(scope: !510, file: !3, line: 196, column: 6)
!543 = !DILocation(line: 196, column: 17, scope: !542, inlinedAt: !534)
!544 = !DILocation(line: 196, column: 15, scope: !542, inlinedAt: !534)
!545 = !DILocation(line: 196, column: 6, scope: !510, inlinedAt: !534)
!546 = !DILocation(line: 355, column: 33, scope: !489)
!547 = !DILocation(line: 204, column: 2, scope: !510, inlinedAt: !534)
!548 = !DILocation(line: 206, column: 8, scope: !549, inlinedAt: !534)
!549 = distinct !DILexicalBlock(scope: !510, file: !3, line: 204, column: 24)
!550 = !DILocation(line: 206, column: 24, scope: !549, inlinedAt: !534)
!551 = !{i64 0, i64 16, !507, i64 0, i64 16, !507, i64 0, i64 16, !507}
!552 = !DILocation(line: 207, column: 3, scope: !549, inlinedAt: !534)
!553 = !DILocation(line: 209, column: 8, scope: !549, inlinedAt: !534)
!554 = !DILocation(line: 209, column: 24, scope: !549, inlinedAt: !534)
!555 = !DILocation(line: 210, column: 3, scope: !549, inlinedAt: !534)
!556 = !DILocation(line: 365, column: 12, scope: !134)
!557 = !DILocation(line: 366, column: 7, scope: !271)
!558 = !DILocation(line: 366, column: 6, scope: !134)
!559 = !DILocation(line: 368, column: 22, scope: !270)
!560 = !DILocation(line: 369, column: 39, scope: !270)
!561 = !DILocation(line: 370, column: 13, scope: !270)
!562 = !DILocation(line: 371, column: 8, scope: !269)
!563 = !DILocation(line: 371, column: 7, scope: !270)
!564 = !DILocation(line: 372, column: 4, scope: !267)
!565 = !DILocation(line: 372, column: 4, scope: !268)
!566 = !DILocation(line: 375, column: 4, scope: !268)
!567 = !DILocation(line: 379, column: 15, scope: !276)
!568 = !{!569, !298, i64 0}
!569 = !{!"ip_hash_info", !298, i64 0, !298, i64 4}
!570 = !DILocation(line: 379, column: 22, scope: !276)
!571 = !DILocation(line: 379, column: 19, scope: !276)
!572 = !DILocation(line: 379, column: 6, scope: !134)
!573 = !DILocation(line: 380, column: 3, scope: !274)
!574 = !DILocation(line: 380, column: 3, scope: !275)
!575 = !DILocation(line: 382, column: 3, scope: !281)
!576 = !DILocation(line: 382, column: 3, scope: !275)
!577 = !DILocation(line: 384, column: 2, scope: !275)
!578 = !DILocation(line: 390, column: 25, scope: !134)
!579 = !{!569, !298, i64 4}
!580 = !DILocation(line: 390, column: 56, scope: !134)
!581 = !DILocation(line: 391, column: 15, scope: !289)
!582 = !DILocation(line: 391, column: 6, scope: !289)
!583 = !DILocation(line: 391, column: 25, scope: !289)
!584 = !DILocation(line: 391, column: 6, scope: !134)
!585 = !DILocation(line: 394, column: 3, scope: !287)
!586 = !DILocation(line: 394, column: 3, scope: !288)
!587 = !DILocation(line: 399, column: 15, scope: !588)
!588 = distinct !DILexicalBlock(scope: !134, file: !3, line: 399, column: 6)
!589 = !DILocation(line: 396, column: 2, scope: !288)
!590 = !DILocation(line: 399, column: 25, scope: !588)
!591 = !DILocation(line: 399, column: 6, scope: !134)
!592 = !DILocation(line: 400, column: 17, scope: !588)
!593 = !DILocation(line: 400, column: 3, scope: !588)
!594 = !DILocation(line: 407, column: 1, scope: !134)
