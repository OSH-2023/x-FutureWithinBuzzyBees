; ModuleID = 'tc_queue_mapping_kern.c'
source_filename = "tc_queue_mapping_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.__sk_buff = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, [5 x i32], i32, i32, i32, i32, i32, i32, i32, i32, [4 x i32], [4 x i32], i32, i32, i32, %union.anon, i64, i32, i32, %union.anon.2 }
%union.anon = type { %struct.bpf_flow_keys* }
%struct.bpf_flow_keys = type { i16, i16, i16, i8, i8, i8, i8, i16, i16, i16, %union.anon.0, i32, i32 }
%union.anon.0 = type { %struct.anon.1 }
%struct.anon.1 = type { [4 x i32], [4 x i32] }
%union.anon.2 = type { %struct.bpf_sock* }
%struct.bpf_sock = type { i32, i32, i32, i32, i32, i32, i32, [4 x i32], i32, i16, i16, i32, [4 x i32], i32 }

@__const.tc_cls_prog.____fmt = private unnamed_addr constant [36 x i8] c"queue_mapping:%u major:%u minor:%u\0A\00", align 1
@__const.tc_cls_prog_test.____fmt = private unnamed_addr constant [55 x i8] c"Tried to change queue_mapping=NO_QUEUE_MAPPING now=%d\0A\00", align 1
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !0
@llvm.used = appending global [3 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (i32 (%struct.__sk_buff*)* @tc_cls_prog to i8*), i8* bitcast (i32 (%struct.__sk_buff*)* @tc_cls_prog_test to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @tc_cls_prog(%struct.__sk_buff* nocapture %0) #0 section "tc" !dbg !33 {
  %2 = alloca [36 x i8], align 1
  call void @llvm.dbg.value(metadata %struct.__sk_buff* %0, metadata !134, metadata !DIExpression()), !dbg !142
  %3 = tail call i64 inttoptr (i64 8 to i64 ()*)() #3, !dbg !143
  %4 = trunc i64 %3 to i32, !dbg !143
  call void @llvm.dbg.value(metadata i64 %3, metadata !135, metadata !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !142
  %5 = add i32 %4, 1, !dbg !144
  %6 = and i32 %5, 65535, !dbg !145
  call void @llvm.dbg.value(metadata i32 %5, metadata !136, metadata !DIExpression()), !dbg !142
  %7 = getelementptr inbounds %struct.__sk_buff, %struct.__sk_buff* %0, i64 0, i32 3, !dbg !146
  store i32 %6, i32* %7, align 4, !dbg !147, !tbaa !148
  %8 = getelementptr inbounds [36 x i8], [36 x i8]* %2, i64 0, i64 0, !dbg !154
  call void @llvm.lifetime.start.p0i8(i64 36, i8* nonnull %8) #3, !dbg !154
  call void @llvm.dbg.declare(metadata [36 x i8]* %2, metadata !137, metadata !DIExpression()), !dbg !154
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(36) %8, i8* nonnull align 1 dereferenceable(36) getelementptr inbounds ([36 x i8], [36 x i8]* @__const.tc_cls_prog.____fmt, i64 0, i64 0), i64 36, i1 false), !dbg !154
  %9 = getelementptr inbounds %struct.__sk_buff, %struct.__sk_buff* %0, i64 0, i32 8, !dbg !154
  %10 = load i32, i32* %9, align 8, !dbg !154, !tbaa !155
  %11 = lshr i32 %10, 16, !dbg !154
  %12 = and i32 %10, 65535, !dbg !154
  %13 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %8, i32 36, i32 %6, i32 %11, i32 %12) #3, !dbg !154
  call void @llvm.lifetime.end.p0i8(i64 36, i8* nonnull %8) #3, !dbg !156
  ret i32 0, !dbg !157
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: nounwind
define dso_local i32 @tc_cls_prog_test(%struct.__sk_buff* nocapture %0) #0 section "tc" !dbg !158 {
  %2 = alloca [55 x i8], align 1
  call void @llvm.dbg.value(metadata %struct.__sk_buff* %0, metadata !160, metadata !DIExpression()), !dbg !166
  %3 = getelementptr inbounds %struct.__sk_buff, %struct.__sk_buff* %0, i64 0, i32 3, !dbg !167
  store i32 65535, i32* %3, align 4, !dbg !168, !tbaa !148
  tail call void asm sideeffect "", "~{memory}"() #3, !dbg !169, !srcloc !170
  %4 = getelementptr inbounds [55 x i8], [55 x i8]* %2, i64 0, i64 0, !dbg !171
  call void @llvm.lifetime.start.p0i8(i64 55, i8* nonnull %4) #3, !dbg !171
  call void @llvm.dbg.declare(metadata [55 x i8]* %2, metadata !161, metadata !DIExpression()), !dbg !171
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 dereferenceable(55) %4, i8* nonnull align 1 dereferenceable(55) getelementptr inbounds ([55 x i8], [55 x i8]* @__const.tc_cls_prog_test.____fmt, i64 0, i64 0), i64 55, i1 false), !dbg !171
  %5 = load i32, i32* %3, align 4, !dbg !171, !tbaa !148
  %6 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %4, i32 55, i32 %5) #3, !dbg !171
  call void @llvm.lifetime.end.p0i8(i64 55, i8* nonnull %4) #3, !dbg !172
  ret i32 0, !dbg !173
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nounwind willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!29, !30, !31}
!llvm.ident = !{!32}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 108, type: !26, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !9, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "tc_queue_mapping_kern.c", directory: "/home/asteria/xdp/xdp_cpumap_tc/src")
!4 = !{}
!5 = !{!6}
!6 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !7, line: 24, baseType: !8)
!7 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!8 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!9 = !{!0, !10, !17}
!10 = !DIGlobalVariableExpression(var: !11, expr: !DIExpression())
!11 = distinct !DIGlobalVariable(name: "bpf_get_smp_processor_id", scope: !2, file: !12, line: 28, type: !13, isLocal: true, isDefinition: true)
!12 = !DIFile(filename: "./../headers/bpf_helpers.h", directory: "/home/asteria/xdp/xdp_cpumap_tc/src")
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DISubroutineType(types: !15)
!15 = !{!16}
!16 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!17 = !DIGlobalVariableExpression(var: !18, expr: !DIExpression())
!18 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !12, line: 24, type: !19, isLocal: true, isDefinition: true)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = !DISubroutineType(types: !21)
!21 = !{!22, !23, !22, null}
!22 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!23 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!24 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !25)
!25 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!26 = !DICompositeType(tag: DW_TAG_array_type, baseType: !25, size: 32, elements: !27)
!27 = !{!28}
!28 = !DISubrange(count: 4)
!29 = !{i32 7, !"Dwarf Version", i32 4}
!30 = !{i32 2, !"Debug Info Version", i32 3}
!31 = !{i32 1, !"wchar_size", i32 4}
!32 = !{!"clang version 10.0.0-4ubuntu1 "}
!33 = distinct !DISubprogram(name: "tc_cls_prog", scope: !3, file: !3, line: 35, type: !34, scopeLine: 36, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !133)
!34 = !DISubroutineType(types: !35)
!35 = !{!22, !36}
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !37, size: 64)
!37 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__sk_buff", file: !38, line: 2972, size: 1408, elements: !39)
!38 = !DIFile(filename: "/usr/include/linux/bpf.h", directory: "")
!39 = !{!40, !43, !44, !45, !46, !47, !48, !49, !50, !51, !52, !53, !54, !58, !59, !60, !61, !62, !63, !64, !65, !66, !68, !69, !70, !71, !72, !109, !111, !112, !113}
!40 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !37, file: !38, line: 2973, baseType: !41, size: 32)
!41 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !7, line: 27, baseType: !42)
!42 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!43 = !DIDerivedType(tag: DW_TAG_member, name: "pkt_type", scope: !37, file: !38, line: 2974, baseType: !41, size: 32, offset: 32)
!44 = !DIDerivedType(tag: DW_TAG_member, name: "mark", scope: !37, file: !38, line: 2975, baseType: !41, size: 32, offset: 64)
!45 = !DIDerivedType(tag: DW_TAG_member, name: "queue_mapping", scope: !37, file: !38, line: 2976, baseType: !41, size: 32, offset: 96)
!46 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !37, file: !38, line: 2977, baseType: !41, size: 32, offset: 128)
!47 = !DIDerivedType(tag: DW_TAG_member, name: "vlan_present", scope: !37, file: !38, line: 2978, baseType: !41, size: 32, offset: 160)
!48 = !DIDerivedType(tag: DW_TAG_member, name: "vlan_tci", scope: !37, file: !38, line: 2979, baseType: !41, size: 32, offset: 192)
!49 = !DIDerivedType(tag: DW_TAG_member, name: "vlan_proto", scope: !37, file: !38, line: 2980, baseType: !41, size: 32, offset: 224)
!50 = !DIDerivedType(tag: DW_TAG_member, name: "priority", scope: !37, file: !38, line: 2981, baseType: !41, size: 32, offset: 256)
!51 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !37, file: !38, line: 2982, baseType: !41, size: 32, offset: 288)
!52 = !DIDerivedType(tag: DW_TAG_member, name: "ifindex", scope: !37, file: !38, line: 2983, baseType: !41, size: 32, offset: 320)
!53 = !DIDerivedType(tag: DW_TAG_member, name: "tc_index", scope: !37, file: !38, line: 2984, baseType: !41, size: 32, offset: 352)
!54 = !DIDerivedType(tag: DW_TAG_member, name: "cb", scope: !37, file: !38, line: 2985, baseType: !55, size: 160, offset: 384)
!55 = !DICompositeType(tag: DW_TAG_array_type, baseType: !41, size: 160, elements: !56)
!56 = !{!57}
!57 = !DISubrange(count: 5)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "hash", scope: !37, file: !38, line: 2986, baseType: !41, size: 32, offset: 544)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "tc_classid", scope: !37, file: !38, line: 2987, baseType: !41, size: 32, offset: 576)
!60 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !37, file: !38, line: 2988, baseType: !41, size: 32, offset: 608)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !37, file: !38, line: 2989, baseType: !41, size: 32, offset: 640)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "napi_id", scope: !37, file: !38, line: 2990, baseType: !41, size: 32, offset: 672)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "family", scope: !37, file: !38, line: 2993, baseType: !41, size: 32, offset: 704)
!64 = !DIDerivedType(tag: DW_TAG_member, name: "remote_ip4", scope: !37, file: !38, line: 2994, baseType: !41, size: 32, offset: 736)
!65 = !DIDerivedType(tag: DW_TAG_member, name: "local_ip4", scope: !37, file: !38, line: 2995, baseType: !41, size: 32, offset: 768)
!66 = !DIDerivedType(tag: DW_TAG_member, name: "remote_ip6", scope: !37, file: !38, line: 2996, baseType: !67, size: 128, offset: 800)
!67 = !DICompositeType(tag: DW_TAG_array_type, baseType: !41, size: 128, elements: !27)
!68 = !DIDerivedType(tag: DW_TAG_member, name: "local_ip6", scope: !37, file: !38, line: 2997, baseType: !67, size: 128, offset: 928)
!69 = !DIDerivedType(tag: DW_TAG_member, name: "remote_port", scope: !37, file: !38, line: 2998, baseType: !41, size: 32, offset: 1056)
!70 = !DIDerivedType(tag: DW_TAG_member, name: "local_port", scope: !37, file: !38, line: 2999, baseType: !41, size: 32, offset: 1088)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !37, file: !38, line: 3002, baseType: !41, size: 32, offset: 1120)
!72 = !DIDerivedType(tag: DW_TAG_member, scope: !37, file: !38, line: 3003, baseType: !73, size: 64, align: 64, offset: 1152)
!73 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !37, file: !38, line: 3003, size: 64, align: 64, elements: !74)
!74 = !{!75}
!75 = !DIDerivedType(tag: DW_TAG_member, name: "flow_keys", scope: !73, file: !38, line: 3003, baseType: !76, size: 64)
!76 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !77, size: 64)
!77 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_flow_keys", file: !38, line: 3553, size: 448, elements: !78)
!78 = !{!79, !80, !81, !82, !85, !86, !87, !88, !91, !92, !93, !107, !108}
!79 = !DIDerivedType(tag: DW_TAG_member, name: "nhoff", scope: !77, file: !38, line: 3554, baseType: !6, size: 16)
!80 = !DIDerivedType(tag: DW_TAG_member, name: "thoff", scope: !77, file: !38, line: 3555, baseType: !6, size: 16, offset: 16)
!81 = !DIDerivedType(tag: DW_TAG_member, name: "addr_proto", scope: !77, file: !38, line: 3556, baseType: !6, size: 16, offset: 32)
!82 = !DIDerivedType(tag: DW_TAG_member, name: "is_frag", scope: !77, file: !38, line: 3557, baseType: !83, size: 8, offset: 48)
!83 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !7, line: 21, baseType: !84)
!84 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!85 = !DIDerivedType(tag: DW_TAG_member, name: "is_first_frag", scope: !77, file: !38, line: 3558, baseType: !83, size: 8, offset: 56)
!86 = !DIDerivedType(tag: DW_TAG_member, name: "is_encap", scope: !77, file: !38, line: 3559, baseType: !83, size: 8, offset: 64)
!87 = !DIDerivedType(tag: DW_TAG_member, name: "ip_proto", scope: !77, file: !38, line: 3560, baseType: !83, size: 8, offset: 72)
!88 = !DIDerivedType(tag: DW_TAG_member, name: "n_proto", scope: !77, file: !38, line: 3561, baseType: !89, size: 16, offset: 80)
!89 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !90, line: 25, baseType: !6)
!90 = !DIFile(filename: "/usr/include/linux/types.h", directory: "")
!91 = !DIDerivedType(tag: DW_TAG_member, name: "sport", scope: !77, file: !38, line: 3562, baseType: !89, size: 16, offset: 96)
!92 = !DIDerivedType(tag: DW_TAG_member, name: "dport", scope: !77, file: !38, line: 3563, baseType: !89, size: 16, offset: 112)
!93 = !DIDerivedType(tag: DW_TAG_member, scope: !77, file: !38, line: 3564, baseType: !94, size: 256, offset: 128)
!94 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !77, file: !38, line: 3564, size: 256, elements: !95)
!95 = !{!96, !102}
!96 = !DIDerivedType(tag: DW_TAG_member, scope: !94, file: !38, line: 3565, baseType: !97, size: 64)
!97 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !94, file: !38, line: 3565, size: 64, elements: !98)
!98 = !{!99, !101}
!99 = !DIDerivedType(tag: DW_TAG_member, name: "ipv4_src", scope: !97, file: !38, line: 3566, baseType: !100, size: 32)
!100 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !90, line: 27, baseType: !41)
!101 = !DIDerivedType(tag: DW_TAG_member, name: "ipv4_dst", scope: !97, file: !38, line: 3567, baseType: !100, size: 32, offset: 32)
!102 = !DIDerivedType(tag: DW_TAG_member, scope: !94, file: !38, line: 3569, baseType: !103, size: 256)
!103 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !94, file: !38, line: 3569, size: 256, elements: !104)
!104 = !{!105, !106}
!105 = !DIDerivedType(tag: DW_TAG_member, name: "ipv6_src", scope: !103, file: !38, line: 3570, baseType: !67, size: 128)
!106 = !DIDerivedType(tag: DW_TAG_member, name: "ipv6_dst", scope: !103, file: !38, line: 3571, baseType: !67, size: 128, offset: 128)
!107 = !DIDerivedType(tag: DW_TAG_member, name: "flags", scope: !77, file: !38, line: 3574, baseType: !41, size: 32, offset: 384)
!108 = !DIDerivedType(tag: DW_TAG_member, name: "flow_label", scope: !77, file: !38, line: 3575, baseType: !100, size: 32, offset: 416)
!109 = !DIDerivedType(tag: DW_TAG_member, name: "tstamp", scope: !37, file: !38, line: 3004, baseType: !110, size: 64, offset: 1216)
!110 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !7, line: 31, baseType: !16)
!111 = !DIDerivedType(tag: DW_TAG_member, name: "wire_len", scope: !37, file: !38, line: 3005, baseType: !41, size: 32, offset: 1280)
!112 = !DIDerivedType(tag: DW_TAG_member, name: "gso_segs", scope: !37, file: !38, line: 3006, baseType: !41, size: 32, offset: 1312)
!113 = !DIDerivedType(tag: DW_TAG_member, scope: !37, file: !38, line: 3007, baseType: !114, size: 64, align: 64, offset: 1344)
!114 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !37, file: !38, line: 3007, size: 64, align: 64, elements: !115)
!115 = !{!116}
!116 = !DIDerivedType(tag: DW_TAG_member, name: "sk", scope: !114, file: !38, line: 3007, baseType: !117, size: 64)
!117 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !118, size: 64)
!118 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_sock", file: !38, line: 3060, size: 608, elements: !119)
!119 = !{!120, !121, !122, !123, !124, !125, !126, !127, !128, !129, !130, !131, !132}
!120 = !DIDerivedType(tag: DW_TAG_member, name: "bound_dev_if", scope: !118, file: !38, line: 3061, baseType: !41, size: 32)
!121 = !DIDerivedType(tag: DW_TAG_member, name: "family", scope: !118, file: !38, line: 3062, baseType: !41, size: 32, offset: 32)
!122 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !118, file: !38, line: 3063, baseType: !41, size: 32, offset: 64)
!123 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !118, file: !38, line: 3064, baseType: !41, size: 32, offset: 96)
!124 = !DIDerivedType(tag: DW_TAG_member, name: "mark", scope: !118, file: !38, line: 3065, baseType: !41, size: 32, offset: 128)
!125 = !DIDerivedType(tag: DW_TAG_member, name: "priority", scope: !118, file: !38, line: 3066, baseType: !41, size: 32, offset: 160)
!126 = !DIDerivedType(tag: DW_TAG_member, name: "src_ip4", scope: !118, file: !38, line: 3068, baseType: !41, size: 32, offset: 192)
!127 = !DIDerivedType(tag: DW_TAG_member, name: "src_ip6", scope: !118, file: !38, line: 3069, baseType: !67, size: 128, offset: 224)
!128 = !DIDerivedType(tag: DW_TAG_member, name: "src_port", scope: !118, file: !38, line: 3070, baseType: !41, size: 32, offset: 352)
!129 = !DIDerivedType(tag: DW_TAG_member, name: "dst_port", scope: !118, file: !38, line: 3071, baseType: !89, size: 16, offset: 384)
!130 = !DIDerivedType(tag: DW_TAG_member, name: "dst_ip4", scope: !118, file: !38, line: 3073, baseType: !41, size: 32, offset: 416)
!131 = !DIDerivedType(tag: DW_TAG_member, name: "dst_ip6", scope: !118, file: !38, line: 3074, baseType: !67, size: 128, offset: 448)
!132 = !DIDerivedType(tag: DW_TAG_member, name: "state", scope: !118, file: !38, line: 3075, baseType: !41, size: 32, offset: 576)
!133 = !{!134, !135, !136, !137}
!134 = !DILocalVariable(name: "skb", arg: 1, scope: !33, file: !3, line: 35, type: !36)
!135 = !DILocalVariable(name: "cpu", scope: !33, file: !3, line: 37, type: !41)
!136 = !DILocalVariable(name: "txq_root_handle", scope: !33, file: !3, line: 38, type: !6)
!137 = !DILocalVariable(name: "____fmt", scope: !138, file: !3, line: 77, type: !139)
!138 = distinct !DILexicalBlock(scope: !33, file: !3, line: 77, column: 2)
!139 = !DICompositeType(tag: DW_TAG_array_type, baseType: !25, size: 288, elements: !140)
!140 = !{!141}
!141 = !DISubrange(count: 36)
!142 = !DILocation(line: 0, scope: !33)
!143 = !DILocation(line: 37, column: 14, scope: !33)
!144 = !DILocation(line: 44, column: 24, scope: !33)
!145 = !DILocation(line: 45, column: 23, scope: !33)
!146 = !DILocation(line: 45, column: 7, scope: !33)
!147 = !DILocation(line: 45, column: 21, scope: !33)
!148 = !{!149, !150, i64 12}
!149 = !{!"__sk_buff", !150, i64 0, !150, i64 4, !150, i64 8, !150, i64 12, !150, i64 16, !150, i64 20, !150, i64 24, !150, i64 28, !150, i64 32, !150, i64 36, !150, i64 40, !150, i64 44, !151, i64 48, !150, i64 68, !150, i64 72, !150, i64 76, !150, i64 80, !150, i64 84, !150, i64 88, !150, i64 92, !150, i64 96, !151, i64 100, !151, i64 116, !150, i64 132, !150, i64 136, !150, i64 140, !151, i64 144, !153, i64 152, !150, i64 160, !150, i64 164, !151, i64 168}
!150 = !{!"int", !151, i64 0}
!151 = !{!"omnipotent char", !152, i64 0}
!152 = !{!"Simple C/C++ TBAA"}
!153 = !{!"long long", !151, i64 0}
!154 = !DILocation(line: 77, column: 2, scope: !138)
!155 = !{!149, !150, i64 32}
!156 = !DILocation(line: 77, column: 2, scope: !33)
!157 = !DILocation(line: 88, column: 2, scope: !33)
!158 = distinct !DISubprogram(name: "tc_cls_prog_test", scope: !3, file: !3, line: 97, type: !34, scopeLine: 98, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !159)
!159 = !{!160, !161}
!160 = !DILocalVariable(name: "skb", arg: 1, scope: !158, file: !3, line: 97, type: !36)
!161 = !DILocalVariable(name: "____fmt", scope: !162, file: !3, line: 102, type: !163)
!162 = distinct !DILexicalBlock(scope: !158, file: !3, line: 102, column: 2)
!163 = !DICompositeType(tag: DW_TAG_array_type, baseType: !25, size: 440, elements: !164)
!164 = !{!165}
!165 = !DISubrange(count: 55)
!166 = !DILocation(line: 0, scope: !158)
!167 = !DILocation(line: 100, column: 7, scope: !158)
!168 = !DILocation(line: 100, column: 21, scope: !158)
!169 = !DILocation(line: 101, column: 2, scope: !158)
!170 = !{i32 -2147253521}
!171 = !DILocation(line: 102, column: 2, scope: !162)
!172 = !DILocation(line: 102, column: 2, scope: !158)
!173 = !DILocation(line: 104, column: 2, scope: !158)
