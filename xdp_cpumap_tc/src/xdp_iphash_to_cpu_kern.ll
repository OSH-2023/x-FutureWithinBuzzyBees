; ModuleID = 'xdp_iphash_to_cpu_kern.c'
source_filename = "xdp_iphash_to_cpu_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [11 x i32]*, [32767 x i32]*, %struct.ip_hash_key*, %struct.ip_hash_info*, [1 x i32]*, [1 x i32]* }
%struct.ip_hash_key = type { i32, %struct.in6_addr }
%struct.in6_addr = type { %union.anon }
%union.anon = type { [4 x i32] }
%struct.ip_hash_info = type { i32, i32 }
%struct.anon.0 = type { [2 x i32]*, [256 x i32]*, i32*, i32*, [1 x i32]* }
%struct.anon.1 = type { [16 x i32]*, [64 x i32]*, i32*, i32*, [1 x i32]* }
%struct.anon.2 = type { [2 x i32]*, [64 x i32]*, i32*, i32* }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.iphdr = type { i8, i8, i16, i16, i16, i8, i8, i16, i32, i32 }
%struct.ipv6hdr = type { i8, [3 x i8], i16, i8, i8, %struct.in6_addr, %struct.in6_addr }

@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !0
@map_ip_hash = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !21
@map_ifindex_type = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !80
@cpu_map = dso_local global %struct.anon.1 zeroinitializer, section ".maps", align 8, !dbg !98
@cpus_available = dso_local global %struct.anon.2 zeroinitializer, section ".maps", align 8, !dbg !113
@llvm.used = appending global [6 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon.1* @cpu_map to i8*), i8* bitcast (%struct.anon.2* @cpus_available to i8*), i8* bitcast (%struct.anon.0* @map_ifindex_type to i8*), i8* bitcast (%struct.anon* @map_ip_hash to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_iphash_to_cpu to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_iphash_to_cpu(%struct.xdp_md* nocapture readonly %0) #0 section "xdp" !dbg !142 {
  %2 = alloca %struct.ip_hash_key, align 4
  call void @llvm.dbg.declare(metadata %struct.ip_hash_key* %2, metadata !172, metadata !DIExpression()), !dbg !181
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca %struct.ip_hash_key, align 4
  call void @llvm.dbg.declare(metadata %struct.ip_hash_key* %5, metadata !232, metadata !DIExpression()), !dbg !245
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !154, metadata !DIExpression()), !dbg !246
  %6 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !247
  %7 = load i32, i32* %6, align 4, !dbg !247, !tbaa !248
  %8 = zext i32 %7 to i64, !dbg !253
  %9 = inttoptr i64 %8 to i8*, !dbg !254
  call void @llvm.dbg.value(metadata i8* %9, metadata !155, metadata !DIExpression()), !dbg !246
  %10 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !255
  %11 = load i32, i32* %10, align 4, !dbg !255, !tbaa !256
  %12 = zext i32 %11 to i64, !dbg !257
  call void @llvm.dbg.value(metadata i64 %12, metadata !156, metadata !DIExpression()), !dbg !246
  %13 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 3, !dbg !258
  %14 = load i32, i32* %13, align 4, !dbg !258, !tbaa !259
  call void @llvm.dbg.value(metadata i32 %14, metadata !157, metadata !DIExpression()), !dbg !246
  %15 = inttoptr i64 %12 to %struct.ethhdr*, !dbg !260
  call void @llvm.dbg.value(metadata %struct.ethhdr* %15, metadata !158, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata i16 0, metadata !169, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata i32 0, metadata !170, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata %struct.ethhdr* %15, metadata !261, metadata !DIExpression()) #3, !dbg !284
  call void @llvm.dbg.value(metadata i8* %9, metadata !268, metadata !DIExpression()) #3, !dbg !284
  call void @llvm.dbg.value(metadata i64 14, metadata !272, metadata !DIExpression()) #3, !dbg !284
  %16 = getelementptr %struct.ethhdr, %struct.ethhdr* %15, i64 0, i32 0, i64 14, !dbg !287
  %17 = icmp ugt i8* %16, %9, !dbg !289
  br i1 %17, label %116, label %18, !dbg !290

18:                                               ; preds = %1
  %19 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %15, i64 0, i32 2, !dbg !291
  %20 = load i16, i16* %19, align 1, !dbg !291, !tbaa !292
  call void @llvm.dbg.value(metadata i16 %20, metadata !271, metadata !DIExpression()) #3, !dbg !284
  %21 = shl i16 %20, 8
  %22 = icmp ult i16 %21, 1536, !dbg !295
  br i1 %22, label %116, label %23, !dbg !297

23:                                               ; preds = %18
  switch i16 %20, label %31 [
    i16 129, label %24
    i16 -22392, label %24
  ], !dbg !298

24:                                               ; preds = %23, %23
  call void @llvm.dbg.value(metadata i8* %16, metadata !273, metadata !DIExpression()) #3, !dbg !299
  call void @llvm.dbg.value(metadata i64 18, metadata !272, metadata !DIExpression()) #3, !dbg !284
  %25 = getelementptr %struct.ethhdr, %struct.ethhdr* %15, i64 0, i32 0, i64 18, !dbg !300
  %26 = icmp ugt i8* %25, %9, !dbg !302
  br i1 %26, label %116, label %27, !dbg !303

27:                                               ; preds = %24
  call void @llvm.dbg.value(metadata i8* %16, metadata !273, metadata !DIExpression()) #3, !dbg !299
  %28 = getelementptr %struct.ethhdr, %struct.ethhdr* %15, i64 0, i32 0, i64 16, !dbg !304
  %29 = bitcast i8* %28 to i16*, !dbg !304
  %30 = load i16, i16* %29, align 2, !dbg !304, !tbaa !305
  call void @llvm.dbg.value(metadata i16 %30, metadata !271, metadata !DIExpression()) #3, !dbg !284
  br label %31

31:                                               ; preds = %27, %23
  %32 = phi i64 [ 14, %23 ], [ 18, %27 ], !dbg !284
  %33 = phi i16 [ %20, %23 ], [ %30, %27 ], !dbg !307
  call void @llvm.dbg.value(metadata i16 %33, metadata !271, metadata !DIExpression()) #3, !dbg !284
  call void @llvm.dbg.value(metadata i64 %32, metadata !272, metadata !DIExpression()) #3, !dbg !284
  switch i16 %33, label %43 [
    i16 129, label %34
    i16 -22392, label %34
  ], !dbg !308

34:                                               ; preds = %31, %31
  call void @llvm.dbg.value(metadata i8* undef, metadata !281, metadata !DIExpression()) #3, !dbg !309
  %35 = add nuw nsw i64 %32, 4, !dbg !310
  call void @llvm.dbg.value(metadata i64 %35, metadata !272, metadata !DIExpression()) #3, !dbg !284
  %36 = getelementptr %struct.ethhdr, %struct.ethhdr* %15, i64 0, i32 0, i64 %35, !dbg !311
  %37 = icmp ugt i8* %36, %9, !dbg !313
  br i1 %37, label %116, label %38, !dbg !314

38:                                               ; preds = %34
  %39 = getelementptr %struct.ethhdr, %struct.ethhdr* %15, i64 0, i32 0, i64 %32, !dbg !315
  call void @llvm.dbg.value(metadata i8* %39, metadata !281, metadata !DIExpression()) #3, !dbg !309
  call void @llvm.dbg.value(metadata i8* %39, metadata !281, metadata !DIExpression()) #3, !dbg !309
  %40 = getelementptr inbounds i8, i8* %39, i64 2, !dbg !316
  %41 = bitcast i8* %40 to i16*, !dbg !316
  %42 = load i16, i16* %41, align 2, !dbg !316, !tbaa !305
  call void @llvm.dbg.value(metadata i16 %42, metadata !271, metadata !DIExpression()) #3, !dbg !284
  br label %43

43:                                               ; preds = %38, %31
  %44 = phi i64 [ %32, %31 ], [ %35, %38 ], !dbg !284
  %45 = phi i16 [ %33, %31 ], [ %42, %38 ], !dbg !307
  call void @llvm.dbg.value(metadata i16 %45, metadata !271, metadata !DIExpression()) #3, !dbg !284
  call void @llvm.dbg.value(metadata i64 %44, metadata !272, metadata !DIExpression()) #3, !dbg !284
  %46 = tail call i16 @llvm.bswap.i16(i16 %45) #3
  call void @llvm.dbg.value(metadata i16 %46, metadata !169, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.value(metadata i64 %44, metadata !170, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !246
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !239, metadata !DIExpression()) #3, !dbg !317
  call void @llvm.dbg.value(metadata i16 %46, metadata !240, metadata !DIExpression()) #3, !dbg !317
  call void @llvm.dbg.value(metadata i64 %44, metadata !241, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #3, !dbg !317
  call void @llvm.dbg.value(metadata i32 %14, metadata !242, metadata !DIExpression()) #3, !dbg !317
  switch i16 %46, label %116 [
    i16 2048, label %47
    i16 -31011, label %47
  ], !dbg !318

47:                                               ; preds = %43, %43
  call void @llvm.dbg.value(metadata i64 %44, metadata !170, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !246
  call void @llvm.dbg.value(metadata i64 %44, metadata !241, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #3, !dbg !317
  %48 = bitcast i32* %3 to i8*, !dbg !319
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %48) #3, !dbg !319
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !187, metadata !DIExpression()) #3, !dbg !319
  call void @llvm.dbg.value(metadata i64 %44, metadata !188, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)) #3, !dbg !319
  call void @llvm.dbg.value(metadata i32 %14, metadata !189, metadata !DIExpression()) #3, !dbg !319
  store i32 %14, i32* %3, align 4, !tbaa !320
  call void @llvm.dbg.value(metadata i16 %46, metadata !190, metadata !DIExpression()) #3, !dbg !319
  call void @llvm.dbg.value(metadata i64 %8, metadata !191, metadata !DIExpression()) #3, !dbg !319
  %49 = inttoptr i64 %12 to i8*, !dbg !321
  call void @llvm.dbg.value(metadata i8* %49, metadata !192, metadata !DIExpression()) #3, !dbg !319
  %50 = getelementptr i8, i8* %49, i64 %44, !dbg !322
  call void @llvm.dbg.value(metadata i8* %50, metadata !193, metadata !DIExpression()) #3, !dbg !319
  call void @llvm.dbg.value(metadata i8* %50, metadata !210, metadata !DIExpression()) #3, !dbg !319
  %51 = bitcast i32* %4 to i8*, !dbg !323
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %51) #3, !dbg !323
  %52 = bitcast %struct.ip_hash_key* %5 to i8*, !dbg !324
  call void @llvm.lifetime.start.p0i8(i64 20, i8* nonnull %52) #3, !dbg !324
  %53 = getelementptr inbounds %struct.ip_hash_key, %struct.ip_hash_key* %5, i64 0, i32 0, !dbg !325
  store i32 128, i32* %53, align 4, !dbg !326, !tbaa !327
  %54 = getelementptr inbounds %struct.ip_hash_key, %struct.ip_hash_key* %5, i64 0, i32 1, !dbg !330
  %55 = getelementptr inbounds %struct.ip_hash_key, %struct.ip_hash_key* %5, i64 0, i32 1, i32 0, i32 0, i64 3, !dbg !331
  call void @llvm.dbg.value(metadata i32* %3, metadata !189, metadata !DIExpression(DW_OP_deref)) #3, !dbg !319
  %56 = bitcast %struct.in6_addr* %54 to i8*, !dbg !332
  call void @llvm.memset.p0i8.i64(i8* nonnull align 4 dereferenceable(16) %56, i8 -1, i64 16, i1 false) #3, !dbg !333
  %57 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @map_ifindex_type to i8*), i8* nonnull %48) #3, !dbg !332
  call void @llvm.dbg.value(metadata i8* %57, metadata !226, metadata !DIExpression()) #3, !dbg !319
  %58 = icmp eq i8* %57, null, !dbg !334
  br i1 %58, label %114, label %59, !dbg !336

59:                                               ; preds = %47
  %60 = bitcast i8* %57 to i32*, !dbg !332
  call void @llvm.dbg.value(metadata i32* %60, metadata !226, metadata !DIExpression()) #3, !dbg !319
  %61 = load i32, i32* %60, align 4, !dbg !337, !tbaa !320
  call void @llvm.dbg.value(metadata i32 %61, metadata !227, metadata !DIExpression()) #3, !dbg !319
  %62 = add i32 %61, -1, !dbg !338
  %63 = icmp ugt i32 %62, 1, !dbg !338
  br i1 %63, label %114, label %64, !dbg !338

64:                                               ; preds = %59
  %65 = icmp eq i16 %45, 8, !dbg !340
  br i1 %65, label %66, label %80, !dbg !342

66:                                               ; preds = %64
  %67 = getelementptr inbounds i8, i8* %50, i64 20, !dbg !343
  %68 = bitcast i8* %67 to %struct.iphdr*, !dbg !343
  %69 = inttoptr i64 %8 to %struct.iphdr*, !dbg !346
  %70 = icmp ugt %struct.iphdr* %68, %69, !dbg !347
  br i1 %70, label %114, label %71, !dbg !348

71:                                               ; preds = %66
  switch i32 %61, label %90 [
    i32 1, label %72
    i32 2, label %76
  ], !dbg !349

72:                                               ; preds = %71
  %73 = getelementptr inbounds i8, i8* %50, i64 16, !dbg !350
  %74 = bitcast i8* %73 to i32*, !dbg !350
  %75 = load i32, i32* %74, align 4, !dbg !350, !tbaa !353
  store i32 %75, i32* %55, align 4, !dbg !355, !tbaa !356
  br label %90, !dbg !357

76:                                               ; preds = %71
  %77 = getelementptr inbounds i8, i8* %50, i64 12, !dbg !358
  %78 = bitcast i8* %77 to i32*, !dbg !358
  %79 = load i32, i32* %78, align 4, !dbg !358, !tbaa !361
  store i32 %79, i32* %55, align 4, !dbg !362, !tbaa !356
  br label %90, !dbg !363

80:                                               ; preds = %64
  %81 = getelementptr inbounds i8, i8* %50, i64 40, !dbg !364
  %82 = bitcast i8* %81 to %struct.ipv6hdr*, !dbg !364
  %83 = inttoptr i64 %8 to %struct.ipv6hdr*, !dbg !367
  %84 = icmp ugt %struct.ipv6hdr* %82, %83, !dbg !368
  br i1 %84, label %114, label %85, !dbg !369

85:                                               ; preds = %80
  switch i32 %61, label %90 [
    i32 1, label %86
    i32 2, label %88
  ], !dbg !370

86:                                               ; preds = %85
  %87 = getelementptr inbounds i8, i8* %50, i64 24, !dbg !371
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(16) %56, i8* nonnull align 4 dereferenceable(16) %87, i64 16, i1 false) #3, !dbg !371, !tbaa.struct !373
  br label %90, !dbg !374

88:                                               ; preds = %85
  %89 = getelementptr inbounds i8, i8* %50, i64 8, !dbg !375
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 4 dereferenceable(16) %56, i8* nonnull align 4 dereferenceable(16) %89, i64 16, i1 false) #3, !dbg !375, !tbaa.struct !373
  br label %90, !dbg !377

90:                                               ; preds = %88, %86, %85, %76, %72, %71
  call void @llvm.dbg.value(metadata %struct.ip_hash_key* %5, metadata !179, metadata !DIExpression()) #3, !dbg !378
  %91 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @map_ip_hash to i8*), i8* nonnull %52) #3, !dbg !379
  call void @llvm.dbg.value(metadata i8* %91, metadata !180, metadata !DIExpression()) #3, !dbg !378
  %92 = icmp eq i8* %91, null, !dbg !380
  br i1 %92, label %93, label %100, !dbg !381

93:                                               ; preds = %90
  %94 = bitcast %struct.ip_hash_key* %2 to i8*, !dbg !382
  call void @llvm.lifetime.start.p0i8(i64 20, i8* nonnull %94) #3, !dbg !382
  %95 = getelementptr inbounds %struct.ip_hash_key, %struct.ip_hash_key* %2, i64 0, i32 0, !dbg !383
  store i32 128, i32* %95, align 4, !dbg !384, !tbaa !327
  %96 = getelementptr inbounds %struct.ip_hash_key, %struct.ip_hash_key* %2, i64 0, i32 1, i32 0, i32 0, i64 0, !dbg !385
  %97 = bitcast i32* %96 to i8*, !dbg !386
  call void @llvm.memset.p0i8.i64(i8* nonnull align 4 dereferenceable(16) %97, i8 -1, i64 16, i1 false) #3, !dbg !387
  %98 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @map_ip_hash to i8*), i8* nonnull %94) #3, !dbg !386
  call void @llvm.dbg.value(metadata i8* %98, metadata !180, metadata !DIExpression()) #3, !dbg !378
  call void @llvm.lifetime.end.p0i8(i64 20, i8* nonnull %94) #3, !dbg !388
  call void @llvm.dbg.value(metadata i8* %98, metadata !180, metadata !DIExpression()) #3, !dbg !378
  call void @llvm.dbg.value(metadata i8* %98, metadata !228, metadata !DIExpression()) #3, !dbg !319
  %99 = icmp eq i8* %98, null, !dbg !389
  br i1 %99, label %114, label %100, !dbg !391

100:                                              ; preds = %93, %90
  %101 = phi i8* [ %98, %93 ], [ %91, %90 ]
  %102 = bitcast i8* %101 to i32*, !dbg !392
  %103 = load i32, i32* %102, align 4, !dbg !392, !tbaa !393
  call void @llvm.dbg.value(metadata i32 %103, metadata !229, metadata !DIExpression()) #3, !dbg !319
  store i32 %103, i32* %4, align 4, !dbg !395, !tbaa !320
  call void @llvm.dbg.value(metadata i32* %4, metadata !229, metadata !DIExpression(DW_OP_deref)) #3, !dbg !319
  %104 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.2* @cpus_available to i8*), i8* nonnull %51) #3, !dbg !396
  call void @llvm.dbg.value(metadata i8* %104, metadata !230, metadata !DIExpression()) #3, !dbg !319
  %105 = icmp eq i8* %104, null, !dbg !397
  br i1 %105, label %114, label %106, !dbg !399

106:                                              ; preds = %100
  %107 = bitcast i8* %104 to i32*, !dbg !396
  call void @llvm.dbg.value(metadata i32* %107, metadata !230, metadata !DIExpression()) #3, !dbg !319
  %108 = load i32, i32* %107, align 4, !dbg !400, !tbaa !320
  call void @llvm.dbg.value(metadata i32 %108, metadata !231, metadata !DIExpression()) #3, !dbg !319
  %109 = icmp ugt i32 %108, 63, !dbg !401
  br i1 %109, label %114, label %110, !dbg !403

110:                                              ; preds = %106
  %111 = zext i32 %108 to i64, !dbg !404
  %112 = call i64 inttoptr (i64 51 to i64 (i8*, i64, i64)*)(i8* bitcast (%struct.anon.1* @cpu_map to i8*), i64 %111, i64 0) #3, !dbg !405
  %113 = trunc i64 %112 to i32, !dbg !405
  br label %114, !dbg !406

114:                                              ; preds = %110, %106, %100, %93, %80, %66, %59, %47
  %115 = phi i32 [ %113, %110 ], [ 2, %47 ], [ 2, %59 ], [ 2, %66 ], [ 2, %80 ], [ 2, %93 ], [ 2, %100 ], [ 2, %106 ], !dbg !319
  call void @llvm.lifetime.end.p0i8(i64 20, i8* nonnull %52) #3, !dbg !407
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %51) #3, !dbg !407
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %48) #3, !dbg !407
  call void @llvm.dbg.value(metadata i32 %115, metadata !243, metadata !DIExpression()) #3, !dbg !317
  br label %116, !dbg !408

116:                                              ; preds = %34, %24, %18, %1, %114, %43
  %117 = phi i32 [ %115, %114 ], [ 2, %43 ], [ 2, %1 ], [ 2, %18 ], [ 2, %24 ], [ 2, %34 ], !dbg !246
  ret i32 %117, !dbg !409
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: nounwind readnone speculatable willreturn
declare i16 @llvm.bswap.i16(i16) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #2

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nounwind willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!138, !139, !140}
!llvm.ident = !{!141}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 261, type: !136, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !14, globals: !20, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "xdp_iphash_to_cpu_kern.c", directory: "/home/asteria/xdp/xdp_cpumap_tc/src")
!4 = !{!5}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 3151, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "/usr/include/linux/bpf.h", directory: "")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0, isUnsigned: true)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1, isUnsigned: true)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2, isUnsigned: true)
!12 = !DIEnumerator(name: "XDP_TX", value: 3, isUnsigned: true)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4, isUnsigned: true)
!14 = !{!15, !16, !17}
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!16 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !18, line: 24, baseType: !19)
!18 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!19 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!20 = !{!0, !21, !80, !98, !113, !121, !129}
!21 = !DIGlobalVariableExpression(var: !22, expr: !DIExpression())
!22 = distinct !DIGlobalVariable(name: "map_ip_hash", scope: !2, file: !23, line: 16, type: !24, isLocal: false, isDefinition: true)
!23 = !DIFile(filename: "./shared_maps.h", directory: "/home/asteria/xdp/xdp_cpumap_tc/src")
!24 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !23, line: 9, size: 384, elements: !25)
!25 = !{!26, !32, !37, !68, !74, !79}
!26 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !24, file: !23, line: 10, baseType: !27, size: 64)
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!28 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 352, elements: !30)
!29 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!30 = !{!31}
!31 = !DISubrange(count: 11)
!32 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !24, file: !23, line: 11, baseType: !33, size: 64, offset: 64)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!34 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 1048544, elements: !35)
!35 = !{!36}
!36 = !DISubrange(count: 32767)
!37 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !24, file: !23, line: 12, baseType: !38, size: 64, offset: 128)
!38 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !39, size: 64)
!39 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ip_hash_key", file: !40, line: 38, size: 160, elements: !41)
!40 = !DIFile(filename: "./common_kern_user.h", directory: "/home/asteria/xdp/xdp_cpumap_tc/src")
!41 = !{!42, !44}
!42 = !DIDerivedType(tag: DW_TAG_member, name: "prefixlen", scope: !39, file: !40, line: 39, baseType: !43, size: 32)
!43 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !18, line: 27, baseType: !7)
!44 = !DIDerivedType(tag: DW_TAG_member, name: "address", scope: !39, file: !40, line: 40, baseType: !45, size: 128, offset: 32)
!45 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "in6_addr", file: !46, line: 33, size: 128, elements: !47)
!46 = !DIFile(filename: "/usr/include/linux/in6.h", directory: "")
!47 = !{!48}
!48 = !DIDerivedType(tag: DW_TAG_member, name: "in6_u", scope: !45, file: !46, line: 40, baseType: !49, size: 128)
!49 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !45, file: !46, line: 34, size: 128, elements: !50)
!50 = !{!51, !57, !63}
!51 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr8", scope: !49, file: !46, line: 35, baseType: !52, size: 128)
!52 = !DICompositeType(tag: DW_TAG_array_type, baseType: !53, size: 128, elements: !55)
!53 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !18, line: 21, baseType: !54)
!54 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!55 = !{!56}
!56 = !DISubrange(count: 16)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr16", scope: !49, file: !46, line: 37, baseType: !58, size: 128)
!58 = !DICompositeType(tag: DW_TAG_array_type, baseType: !59, size: 128, elements: !61)
!59 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !60, line: 25, baseType: !17)
!60 = !DIFile(filename: "/usr/include/linux/types.h", directory: "")
!61 = !{!62}
!62 = !DISubrange(count: 8)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr32", scope: !49, file: !46, line: 38, baseType: !64, size: 128)
!64 = !DICompositeType(tag: DW_TAG_array_type, baseType: !65, size: 128, elements: !66)
!65 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !60, line: 27, baseType: !43)
!66 = !{!67}
!67 = !DISubrange(count: 4)
!68 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !24, file: !23, line: 13, baseType: !69, size: 64, offset: 192)
!69 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !70, size: 64)
!70 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ip_hash_info", file: !40, line: 31, size: 64, elements: !71)
!71 = !{!72, !73}
!72 = !DIDerivedType(tag: DW_TAG_member, name: "cpu", scope: !70, file: !40, line: 33, baseType: !43, size: 32)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "tc_handle", scope: !70, file: !40, line: 34, baseType: !43, size: 32, offset: 32)
!74 = !DIDerivedType(tag: DW_TAG_member, name: "pinning", scope: !24, file: !23, line: 14, baseType: !75, size: 64, offset: 256)
!75 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !76, size: 64)
!76 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 32, elements: !77)
!77 = !{!78}
!78 = !DISubrange(count: 1)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "map_flags", scope: !24, file: !23, line: 15, baseType: !75, size: 64, offset: 320)
!80 = !DIGlobalVariableExpression(var: !81, expr: !DIExpression())
!81 = distinct !DIGlobalVariable(name: "map_ifindex_type", scope: !2, file: !23, line: 25, type: !82, isLocal: false, isDefinition: true)
!82 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !23, line: 19, size: 320, elements: !83)
!83 = !{!84, !89, !94, !96, !97}
!84 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !82, file: !23, line: 20, baseType: !85, size: 64)
!85 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !86, size: 64)
!86 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 64, elements: !87)
!87 = !{!88}
!88 = !DISubrange(count: 2)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !82, file: !23, line: 21, baseType: !90, size: 64, offset: 64)
!90 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !91, size: 64)
!91 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 8192, elements: !92)
!92 = !{!93}
!93 = !DISubrange(count: 256)
!94 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !82, file: !23, line: 22, baseType: !95, size: 64, offset: 128)
!95 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !43, size: 64)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !82, file: !23, line: 23, baseType: !95, size: 64, offset: 192)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "pinning", scope: !82, file: !23, line: 24, baseType: !75, size: 64, offset: 256)
!98 = !DIGlobalVariableExpression(var: !99, expr: !DIExpression())
!99 = distinct !DIGlobalVariable(name: "cpu_map", scope: !2, file: !3, line: 33, type: !100, isLocal: false, isDefinition: true)
!100 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 27, size: 320, elements: !101)
!101 = !{!102, !105, !110, !111, !112}
!102 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !100, file: !3, line: 28, baseType: !103, size: 64)
!103 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !104, size: 64)
!104 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 512, elements: !55)
!105 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !100, file: !3, line: 29, baseType: !106, size: 64, offset: 64)
!106 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !107, size: 64)
!107 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 2048, elements: !108)
!108 = !{!109}
!109 = !DISubrange(count: 64)
!110 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !100, file: !3, line: 30, baseType: !95, size: 64, offset: 128)
!111 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !100, file: !3, line: 31, baseType: !95, size: 64, offset: 192)
!112 = !DIDerivedType(tag: DW_TAG_member, name: "pinning", scope: !100, file: !3, line: 32, baseType: !75, size: 64, offset: 256)
!113 = !DIGlobalVariableExpression(var: !114, expr: !DIExpression())
!114 = distinct !DIGlobalVariable(name: "cpus_available", scope: !2, file: !3, line: 40, type: !115, isLocal: false, isDefinition: true)
!115 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 35, size: 256, elements: !116)
!116 = !{!117, !118, !119, !120}
!117 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !115, file: !3, line: 36, baseType: !85, size: 64)
!118 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !115, file: !3, line: 37, baseType: !106, size: 64, offset: 64)
!119 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !115, file: !3, line: 38, baseType: !95, size: 64, offset: 128)
!120 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !115, file: !3, line: 39, baseType: !95, size: 64, offset: 192)
!121 = !DIGlobalVariableExpression(var: !122, expr: !DIExpression())
!122 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !123, line: 56, type: !124, isLocal: true, isDefinition: true)
!123 = !DIFile(filename: "../libbpf/src/../../libbpf-install/usr/include/bpf/bpf_helper_defs.h", directory: "/home/asteria/xdp/xdp_cpumap_tc/src")
!124 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !125, size: 64)
!125 = !DISubroutineType(types: !126)
!126 = !{!15, !15, !127}
!127 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !128, size: 64)
!128 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!129 = !DIGlobalVariableExpression(var: !130, expr: !DIExpression())
!130 = distinct !DIGlobalVariable(name: "bpf_redirect_map", scope: !2, file: !123, line: 1323, type: !131, isLocal: true, isDefinition: true)
!131 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !132, size: 64)
!132 = !DISubroutineType(types: !133)
!133 = !{!16, !15, !134, !134}
!134 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !18, line: 31, baseType: !135)
!135 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!136 = !DICompositeType(tag: DW_TAG_array_type, baseType: !137, size: 32, elements: !66)
!137 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!138 = !{i32 7, !"Dwarf Version", i32 4}
!139 = !{i32 2, !"Debug Info Version", i32 3}
!140 = !{i32 1, !"wchar_size", i32 4}
!141 = !{!"clang version 10.0.0-4ubuntu1 "}
!142 = distinct !DISubprogram(name: "xdp_iphash_to_cpu", scope: !3, file: !3, line: 239, type: !143, scopeLine: 240, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !153)
!143 = !DISubroutineType(types: !144)
!144 = !{!29, !145}
!145 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !146, size: 64)
!146 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 3162, size: 160, elements: !147)
!147 = !{!148, !149, !150, !151, !152}
!148 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !146, file: !6, line: 3163, baseType: !43, size: 32)
!149 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !146, file: !6, line: 3164, baseType: !43, size: 32, offset: 32)
!150 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !146, file: !6, line: 3165, baseType: !43, size: 32, offset: 64)
!151 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !146, file: !6, line: 3167, baseType: !43, size: 32, offset: 96)
!152 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !146, file: !6, line: 3168, baseType: !43, size: 32, offset: 128)
!153 = !{!154, !155, !156, !157, !158, !169, !170, !171}
!154 = !DILocalVariable(name: "ctx", arg: 1, scope: !142, file: !3, line: 239, type: !145)
!155 = !DILocalVariable(name: "data_end", scope: !142, file: !3, line: 241, type: !15)
!156 = !DILocalVariable(name: "data", scope: !142, file: !3, line: 242, type: !15)
!157 = !DILocalVariable(name: "ifindex", scope: !142, file: !3, line: 243, type: !43)
!158 = !DILocalVariable(name: "eth", scope: !142, file: !3, line: 244, type: !159)
!159 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !160, size: 64)
!160 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !161, line: 163, size: 112, elements: !162)
!161 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "")
!162 = !{!163, !167, !168}
!163 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !160, file: !161, line: 164, baseType: !164, size: 48)
!164 = !DICompositeType(tag: DW_TAG_array_type, baseType: !54, size: 48, elements: !165)
!165 = !{!166}
!166 = !DISubrange(count: 6)
!167 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !160, file: !161, line: 165, baseType: !164, size: 48, offset: 48)
!168 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !160, file: !161, line: 166, baseType: !59, size: 16, offset: 96)
!169 = !DILocalVariable(name: "eth_proto", scope: !142, file: !3, line: 245, type: !17)
!170 = !DILocalVariable(name: "l3_offset", scope: !142, file: !3, line: 246, type: !43)
!171 = !DILocalVariable(name: "action", scope: !142, file: !3, line: 247, type: !43)
!172 = !DILocalVariable(name: "null_addr", scope: !173, file: !3, line: 111, type: !39)
!173 = distinct !DILexicalBlock(scope: !174, file: !3, line: 110, column: 16)
!174 = distinct !DILexicalBlock(scope: !175, file: !3, line: 110, column: 6)
!175 = distinct !DISubprogram(name: "get_ip_info", scope: !3, file: !3, line: 105, type: !176, scopeLine: 106, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !178)
!176 = !DISubroutineType(types: !177)
!177 = !{!69, !38}
!178 = !{!179, !180, !172}
!179 = !DILocalVariable(name: "ip", arg: 1, scope: !175, file: !3, line: 105, type: !38)
!180 = !DILocalVariable(name: "ip_info", scope: !175, file: !3, line: 107, type: !69)
!181 = !DILocation(line: 111, column: 22, scope: !173, inlinedAt: !182)
!182 = distinct !DILocation(line: 190, column: 12, scope: !183, inlinedAt: !233)
!183 = distinct !DISubprogram(name: "parse_ip", scope: !3, file: !3, line: 129, type: !184, scopeLine: 130, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !186)
!184 = !DISubroutineType(types: !185)
!185 = !{!43, !145, !43, !43, !17}
!186 = !{!187, !188, !189, !190, !191, !192, !193, !210, !226, !227, !228, !229, !230, !231, !232}
!187 = !DILocalVariable(name: "ctx", arg: 1, scope: !183, file: !3, line: 129, type: !145)
!188 = !DILocalVariable(name: "l3_offset", arg: 2, scope: !183, file: !3, line: 129, type: !43)
!189 = !DILocalVariable(name: "ifindex", arg: 3, scope: !183, file: !3, line: 129, type: !43)
!190 = !DILocalVariable(name: "eth_proto", arg: 4, scope: !183, file: !3, line: 129, type: !17)
!191 = !DILocalVariable(name: "data_end", scope: !183, file: !3, line: 131, type: !15)
!192 = !DILocalVariable(name: "data", scope: !183, file: !3, line: 132, type: !15)
!193 = !DILocalVariable(name: "iph", scope: !183, file: !3, line: 135, type: !194)
!194 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !195, size: 64)
!195 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !196, line: 86, size: 160, elements: !197)
!196 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "")
!197 = !{!198, !199, !200, !201, !202, !203, !204, !205, !206, !208, !209}
!198 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !195, file: !196, line: 88, baseType: !53, size: 4, flags: DIFlagBitField, extraData: i64 0)
!199 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !195, file: !196, line: 89, baseType: !53, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!200 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !195, file: !196, line: 96, baseType: !53, size: 8, offset: 8)
!201 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !195, file: !196, line: 97, baseType: !59, size: 16, offset: 16)
!202 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !195, file: !196, line: 98, baseType: !59, size: 16, offset: 32)
!203 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !195, file: !196, line: 99, baseType: !59, size: 16, offset: 48)
!204 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !195, file: !196, line: 100, baseType: !53, size: 8, offset: 64)
!205 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !195, file: !196, line: 101, baseType: !53, size: 8, offset: 72)
!206 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !195, file: !196, line: 102, baseType: !207, size: 16, offset: 80)
!207 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !60, line: 31, baseType: !17)
!208 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !195, file: !196, line: 103, baseType: !65, size: 32, offset: 96)
!209 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !195, file: !196, line: 104, baseType: !65, size: 32, offset: 128)
!210 = !DILocalVariable(name: "ip6h", scope: !183, file: !3, line: 136, type: !211)
!211 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !212, size: 64)
!212 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ipv6hdr", file: !213, line: 116, size: 320, elements: !214)
!213 = !DIFile(filename: "/usr/include/linux/ipv6.h", directory: "")
!214 = !{!215, !216, !217, !221, !222, !223, !224, !225}
!215 = !DIDerivedType(tag: DW_TAG_member, name: "priority", scope: !212, file: !213, line: 118, baseType: !53, size: 4, flags: DIFlagBitField, extraData: i64 0)
!216 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !212, file: !213, line: 119, baseType: !53, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!217 = !DIDerivedType(tag: DW_TAG_member, name: "flow_lbl", scope: !212, file: !213, line: 126, baseType: !218, size: 24, offset: 8)
!218 = !DICompositeType(tag: DW_TAG_array_type, baseType: !53, size: 24, elements: !219)
!219 = !{!220}
!220 = !DISubrange(count: 3)
!221 = !DIDerivedType(tag: DW_TAG_member, name: "payload_len", scope: !212, file: !213, line: 128, baseType: !59, size: 16, offset: 32)
!222 = !DIDerivedType(tag: DW_TAG_member, name: "nexthdr", scope: !212, file: !213, line: 129, baseType: !53, size: 8, offset: 48)
!223 = !DIDerivedType(tag: DW_TAG_member, name: "hop_limit", scope: !212, file: !213, line: 130, baseType: !53, size: 8, offset: 56)
!224 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !212, file: !213, line: 132, baseType: !45, size: 128, offset: 64)
!225 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !212, file: !213, line: 133, baseType: !45, size: 128, offset: 192)
!226 = !DILocalVariable(name: "direction_lookup", scope: !183, file: !3, line: 137, type: !95)
!227 = !DILocalVariable(name: "direction", scope: !183, file: !3, line: 138, type: !43)
!228 = !DILocalVariable(name: "ip_info", scope: !183, file: !3, line: 139, type: !69)
!229 = !DILocalVariable(name: "cpu_id", scope: !183, file: !3, line: 141, type: !43)
!230 = !DILocalVariable(name: "cpu_lookup", scope: !183, file: !3, line: 142, type: !95)
!231 = !DILocalVariable(name: "cpu_dest", scope: !183, file: !3, line: 143, type: !43)
!232 = !DILocalVariable(name: "lookup", scope: !183, file: !3, line: 146, type: !39)
!233 = distinct !DILocation(line: 225, column: 12, scope: !234, inlinedAt: !244)
!234 = distinct !DILexicalBlock(scope: !235, file: !3, line: 222, column: 21)
!235 = distinct !DISubprogram(name: "handle_eth_protocol", scope: !3, file: !3, line: 217, type: !236, scopeLine: 219, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !238)
!236 = !DISubroutineType(types: !237)
!237 = !{!43, !145, !17, !43, !43}
!238 = !{!239, !240, !241, !242, !243}
!239 = !DILocalVariable(name: "ctx", arg: 1, scope: !235, file: !3, line: 217, type: !145)
!240 = !DILocalVariable(name: "eth_proto", arg: 2, scope: !235, file: !3, line: 217, type: !17)
!241 = !DILocalVariable(name: "l3_offset", arg: 3, scope: !235, file: !3, line: 217, type: !43)
!242 = !DILocalVariable(name: "ifindex", arg: 4, scope: !235, file: !3, line: 218, type: !43)
!243 = !DILocalVariable(name: "action", scope: !235, file: !3, line: 220, type: !43)
!244 = distinct !DILocation(line: 255, column: 11, scope: !142)
!245 = !DILocation(line: 146, column: 21, scope: !183, inlinedAt: !233)
!246 = !DILocation(line: 0, scope: !142)
!247 = !DILocation(line: 241, column: 38, scope: !142)
!248 = !{!249, !250, i64 4}
!249 = !{!"xdp_md", !250, i64 0, !250, i64 4, !250, i64 8, !250, i64 12, !250, i64 16}
!250 = !{!"int", !251, i64 0}
!251 = !{!"omnipotent char", !252, i64 0}
!252 = !{!"Simple C/C++ TBAA"}
!253 = !DILocation(line: 241, column: 27, scope: !142)
!254 = !DILocation(line: 241, column: 19, scope: !142)
!255 = !DILocation(line: 242, column: 38, scope: !142)
!256 = !{!249, !250, i64 0}
!257 = !DILocation(line: 242, column: 27, scope: !142)
!258 = !DILocation(line: 243, column: 24, scope: !142)
!259 = !{!249, !250, i64 12}
!260 = !DILocation(line: 244, column: 23, scope: !142)
!261 = !DILocalVariable(name: "eth", arg: 1, scope: !262, file: !3, line: 61, type: !159)
!262 = distinct !DISubprogram(name: "parse_eth", scope: !3, file: !3, line: 61, type: !263, scopeLine: 63, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !267)
!263 = !DISubroutineType(types: !264)
!264 = !{!265, !159, !15, !266, !95}
!265 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!266 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!267 = !{!261, !268, !269, !270, !271, !272, !273, !281}
!268 = !DILocalVariable(name: "data_end", arg: 2, scope: !262, file: !3, line: 61, type: !15)
!269 = !DILocalVariable(name: "eth_proto", arg: 3, scope: !262, file: !3, line: 62, type: !266)
!270 = !DILocalVariable(name: "l3_offset", arg: 4, scope: !262, file: !3, line: 62, type: !95)
!271 = !DILocalVariable(name: "eth_type", scope: !262, file: !3, line: 64, type: !17)
!272 = !DILocalVariable(name: "offset", scope: !262, file: !3, line: 65, type: !134)
!273 = !DILocalVariable(name: "vlan_hdr", scope: !274, file: !3, line: 80, type: !276)
!274 = distinct !DILexicalBlock(scope: !275, file: !3, line: 79, column: 43)
!275 = distinct !DILexicalBlock(scope: !262, file: !3, line: 78, column: 6)
!276 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !277, size: 64)
!277 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vlan_hdr", file: !3, line: 21, size: 32, elements: !278)
!278 = !{!279, !280}
!279 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_TCI", scope: !277, file: !3, line: 22, baseType: !59, size: 16)
!280 = !DIDerivedType(tag: DW_TAG_member, name: "h_vlan_encapsulated_proto", scope: !277, file: !3, line: 23, baseType: !59, size: 16, offset: 16)
!281 = !DILocalVariable(name: "vlan_hdr", scope: !282, file: !3, line: 91, type: !276)
!282 = distinct !DILexicalBlock(scope: !283, file: !3, line: 90, column: 43)
!283 = distinct !DILexicalBlock(scope: !262, file: !3, line: 89, column: 6)
!284 = !DILocation(line: 0, scope: !262, inlinedAt: !285)
!285 = distinct !DILocation(line: 249, column: 8, scope: !286)
!286 = distinct !DILexicalBlock(scope: !142, file: !3, line: 249, column: 6)
!287 = !DILocation(line: 68, column: 18, scope: !288, inlinedAt: !285)
!288 = distinct !DILexicalBlock(scope: !262, file: !3, line: 68, column: 6)
!289 = !DILocation(line: 68, column: 27, scope: !288, inlinedAt: !285)
!290 = !DILocation(line: 68, column: 6, scope: !262, inlinedAt: !285)
!291 = !DILocation(line: 71, column: 18, scope: !262, inlinedAt: !285)
!292 = !{!293, !294, i64 12}
!293 = !{!"ethhdr", !251, i64 0, !251, i64 6, !294, i64 12}
!294 = !{!"short", !251, i64 0}
!295 = !DILocation(line: 74, column: 26, scope: !296, inlinedAt: !285)
!296 = distinct !DILexicalBlock(scope: !262, file: !3, line: 74, column: 6)
!297 = !DILocation(line: 74, column: 6, scope: !262, inlinedAt: !285)
!298 = !DILocation(line: 78, column: 41, scope: !275, inlinedAt: !285)
!299 = !DILocation(line: 0, scope: !274, inlinedAt: !285)
!300 = !DILocation(line: 84, column: 19, scope: !301, inlinedAt: !285)
!301 = distinct !DILexicalBlock(scope: !274, file: !3, line: 84, column: 7)
!302 = !DILocation(line: 84, column: 28, scope: !301, inlinedAt: !285)
!303 = !DILocation(line: 84, column: 7, scope: !274, inlinedAt: !285)
!304 = !DILocation(line: 86, column: 24, scope: !274, inlinedAt: !285)
!305 = !{!306, !294, i64 2}
!306 = !{!"vlan_hdr", !294, i64 0, !294, i64 2}
!307 = !DILocation(line: 71, column: 11, scope: !262, inlinedAt: !285)
!308 = !DILocation(line: 89, column: 41, scope: !283, inlinedAt: !285)
!309 = !DILocation(line: 0, scope: !282, inlinedAt: !285)
!310 = !DILocation(line: 94, column: 10, scope: !282, inlinedAt: !285)
!311 = !DILocation(line: 95, column: 19, scope: !312, inlinedAt: !285)
!312 = distinct !DILexicalBlock(scope: !282, file: !3, line: 95, column: 7)
!313 = !DILocation(line: 95, column: 28, scope: !312, inlinedAt: !285)
!314 = !DILocation(line: 95, column: 7, scope: !282, inlinedAt: !285)
!315 = !DILocation(line: 93, column: 26, scope: !282, inlinedAt: !285)
!316 = !DILocation(line: 97, column: 24, scope: !282, inlinedAt: !285)
!317 = !DILocation(line: 0, scope: !235, inlinedAt: !244)
!318 = !DILocation(line: 222, column: 2, scope: !235, inlinedAt: !244)
!319 = !DILocation(line: 0, scope: !183, inlinedAt: !233)
!320 = !{!250, !250, i64 0}
!321 = !DILocation(line: 132, column: 19, scope: !183, inlinedAt: !233)
!322 = !DILocation(line: 135, column: 27, scope: !183, inlinedAt: !233)
!323 = !DILocation(line: 141, column: 2, scope: !183, inlinedAt: !233)
!324 = !DILocation(line: 146, column: 2, scope: !183, inlinedAt: !233)
!325 = !DILocation(line: 147, column: 16, scope: !183, inlinedAt: !233)
!326 = !DILocation(line: 147, column: 26, scope: !183, inlinedAt: !233)
!327 = !{!328, !250, i64 0}
!328 = !{!"ip_hash_key", !250, i64 0, !329, i64 4}
!329 = !{!"in6_addr", !251, i64 0}
!330 = !DILocation(line: 148, column: 16, scope: !183, inlinedAt: !233)
!331 = !DILocation(line: 151, column: 9, scope: !183, inlinedAt: !233)
!332 = !DILocation(line: 154, column: 21, scope: !183, inlinedAt: !233)
!333 = !DILocation(line: 149, column: 43, scope: !183, inlinedAt: !233)
!334 = !DILocation(line: 155, column: 7, scope: !335, inlinedAt: !233)
!335 = distinct !DILexicalBlock(scope: !183, file: !3, line: 155, column: 6)
!336 = !DILocation(line: 155, column: 6, scope: !183, inlinedAt: !233)
!337 = !DILocation(line: 157, column: 14, scope: !183, inlinedAt: !233)
!338 = !DILocation(line: 158, column: 33, scope: !339, inlinedAt: !233)
!339 = distinct !DILexicalBlock(scope: !183, file: !3, line: 158, column: 6)
!340 = !DILocation(line: 166, column: 16, scope: !341, inlinedAt: !233)
!341 = distinct !DILexicalBlock(scope: !183, file: !3, line: 166, column: 6)
!342 = !DILocation(line: 166, column: 6, scope: !183, inlinedAt: !233)
!343 = !DILocation(line: 168, column: 11, scope: !344, inlinedAt: !233)
!344 = distinct !DILexicalBlock(scope: !345, file: !3, line: 168, column: 7)
!345 = distinct !DILexicalBlock(scope: !341, file: !3, line: 166, column: 29)
!346 = !DILocation(line: 168, column: 17, scope: !344, inlinedAt: !233)
!347 = !DILocation(line: 168, column: 15, scope: !344, inlinedAt: !233)
!348 = !DILocation(line: 168, column: 7, scope: !345, inlinedAt: !233)
!349 = !DILocation(line: 174, column: 7, scope: !345, inlinedAt: !233)
!350 = !DILocation(line: 175, column: 45, scope: !351, inlinedAt: !233)
!351 = distinct !DILexicalBlock(scope: !352, file: !3, line: 174, column: 35)
!352 = distinct !DILexicalBlock(scope: !345, file: !3, line: 174, column: 7)
!353 = !{!354, !250, i64 16}
!354 = !{!"iphdr", !251, i64 0, !251, i64 0, !251, i64 1, !294, i64 2, !294, i64 4, !294, i64 6, !251, i64 8, !251, i64 9, !294, i64 10, !250, i64 12, !250, i64 16}
!355 = !DILocation(line: 175, column: 38, scope: !351, inlinedAt: !233)
!356 = !{!251, !251, i64 0}
!357 = !DILocation(line: 176, column: 3, scope: !351, inlinedAt: !233)
!358 = !DILocation(line: 177, column: 45, scope: !359, inlinedAt: !233)
!359 = distinct !DILexicalBlock(scope: !360, file: !3, line: 176, column: 42)
!360 = distinct !DILexicalBlock(scope: !352, file: !3, line: 176, column: 14)
!361 = !{!354, !250, i64 12}
!362 = !DILocation(line: 177, column: 38, scope: !359, inlinedAt: !233)
!363 = !DILocation(line: 178, column: 3, scope: !359, inlinedAt: !233)
!364 = !DILocation(line: 180, column: 12, scope: !365, inlinedAt: !233)
!365 = distinct !DILexicalBlock(scope: !366, file: !3, line: 180, column: 7)
!366 = distinct !DILexicalBlock(scope: !341, file: !3, line: 179, column: 9)
!367 = !DILocation(line: 180, column: 18, scope: !365, inlinedAt: !233)
!368 = !DILocation(line: 180, column: 16, scope: !365, inlinedAt: !233)
!369 = !DILocation(line: 180, column: 7, scope: !366, inlinedAt: !233)
!370 = !DILocation(line: 184, column: 7, scope: !366, inlinedAt: !233)
!371 = !DILocation(line: 185, column: 27, scope: !372, inlinedAt: !233)
!372 = distinct !DILexicalBlock(scope: !366, file: !3, line: 184, column: 7)
!373 = !{i64 0, i64 16, !356, i64 0, i64 16, !356, i64 0, i64 16, !356}
!374 = !DILocation(line: 185, column: 4, scope: !372, inlinedAt: !233)
!375 = !DILocation(line: 187, column: 27, scope: !376, inlinedAt: !233)
!376 = distinct !DILexicalBlock(scope: !372, file: !3, line: 186, column: 12)
!377 = !DILocation(line: 187, column: 4, scope: !376, inlinedAt: !233)
!378 = !DILocation(line: 0, scope: !175, inlinedAt: !182)
!379 = !DILocation(line: 109, column: 12, scope: !175, inlinedAt: !182)
!380 = !DILocation(line: 110, column: 7, scope: !174, inlinedAt: !182)
!381 = !DILocation(line: 110, column: 6, scope: !175, inlinedAt: !182)
!382 = !DILocation(line: 111, column: 3, scope: !173, inlinedAt: !182)
!383 = !DILocation(line: 112, column: 20, scope: !173, inlinedAt: !182)
!384 = !DILocation(line: 112, column: 30, scope: !173, inlinedAt: !182)
!385 = !DILocation(line: 113, column: 10, scope: !173, inlinedAt: !182)
!386 = !DILocation(line: 123, column: 13, scope: !173, inlinedAt: !182)
!387 = !DILocation(line: 114, column: 47, scope: !173, inlinedAt: !182)
!388 = !DILocation(line: 124, column: 2, scope: !174, inlinedAt: !182)
!389 = !DILocation(line: 191, column: 7, scope: !390, inlinedAt: !233)
!390 = distinct !DILexicalBlock(scope: !183, file: !3, line: 191, column: 6)
!391 = !DILocation(line: 191, column: 6, scope: !183, inlinedAt: !233)
!392 = !DILocation(line: 195, column: 20, scope: !183, inlinedAt: !233)
!393 = !{!394, !250, i64 0}
!394 = !{!"ip_hash_info", !250, i64 0, !250, i64 4}
!395 = !DILocation(line: 195, column: 9, scope: !183, inlinedAt: !233)
!396 = !DILocation(line: 201, column: 22, scope: !183, inlinedAt: !233)
!397 = !DILocation(line: 202, column: 7, scope: !398, inlinedAt: !233)
!398 = distinct !DILexicalBlock(scope: !183, file: !3, line: 202, column: 6)
!399 = !DILocation(line: 202, column: 6, scope: !183, inlinedAt: !233)
!400 = !DILocation(line: 206, column: 13, scope: !183, inlinedAt: !233)
!401 = !DILocation(line: 207, column: 15, scope: !402, inlinedAt: !233)
!402 = distinct !DILexicalBlock(scope: !183, file: !3, line: 207, column: 6)
!403 = !DILocation(line: 207, column: 6, scope: !183, inlinedAt: !233)
!404 = !DILocation(line: 213, column: 36, scope: !183, inlinedAt: !233)
!405 = !DILocation(line: 213, column: 9, scope: !183, inlinedAt: !233)
!406 = !DILocation(line: 213, column: 2, scope: !183, inlinedAt: !233)
!407 = !DILocation(line: 214, column: 1, scope: !183, inlinedAt: !233)
!408 = !DILocation(line: 226, column: 3, scope: !234, inlinedAt: !244)
!409 = !DILocation(line: 259, column: 1, scope: !142)
