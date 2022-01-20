; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.bpf_map_def = type { i32, i32, i32, i32, i32 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }

@xdp_stats_map = dso_local global %struct.bpf_map_def { i32 6, i32 4, i32 16, i32 5, i32 0 }, section "maps", align 4, !dbg !0
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !18
@llvm.used = appending global [5 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_abort_func to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_drop_func to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_pass_func to i8*), i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_pass_func(%struct.xdp_md* nocapture readonly %0) #0 section "xdp_pass" !dbg !44 {
  %2 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !59, metadata !DIExpression()), !dbg !61
  call void @llvm.dbg.value(metadata i32 2, metadata !60, metadata !DIExpression()), !dbg !61
  %3 = bitcast i32* %2 to i8*, !dbg !62
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %3), !dbg !62
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !67, metadata !DIExpression()) #3, !dbg !62
  call void @llvm.dbg.value(metadata i32 2, metadata !68, metadata !DIExpression()) #3, !dbg !62
  store i32 2, i32* %2, align 4, !tbaa !82
  %4 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !86
  %5 = load i32, i32* %4, align 4, !dbg !86, !tbaa !87
  call void @llvm.dbg.value(metadata i32 %5, metadata !69, metadata !DIExpression()) #3, !dbg !62
  %6 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !89
  %7 = load i32, i32* %6, align 4, !dbg !89, !tbaa !90
  call void @llvm.dbg.value(metadata i32 %7, metadata !70, metadata !DIExpression()) #3, !dbg !62
  call void @llvm.dbg.value(metadata i32* %2, metadata !68, metadata !DIExpression(DW_OP_deref)) #3, !dbg !62
  %8 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* nonnull %3) #3, !dbg !91
  call void @llvm.dbg.value(metadata i8* %8, metadata !71, metadata !DIExpression()) #3, !dbg !62
  %9 = icmp eq i8* %8, null, !dbg !92
  br i1 %9, label %22, label %10, !dbg !94

10:                                               ; preds = %1
  %11 = zext i32 %7 to i64, !dbg !95
  call void @llvm.dbg.value(metadata i64 %11, metadata !70, metadata !DIExpression()) #3, !dbg !62
  %12 = zext i32 %5 to i64, !dbg !96
  call void @llvm.dbg.value(metadata i64 %12, metadata !69, metadata !DIExpression()) #3, !dbg !62
  call void @llvm.dbg.value(metadata i8* %8, metadata !71, metadata !DIExpression()) #3, !dbg !62
  %13 = sub nsw i64 %12, %11, !dbg !97
  call void @llvm.dbg.value(metadata i64 %13, metadata !80, metadata !DIExpression()) #3, !dbg !62
  %14 = bitcast i8* %8 to i64*, !dbg !98
  %15 = load i64, i64* %14, align 8, !dbg !99, !tbaa !100
  %16 = add i64 %15, 1, !dbg !99
  store i64 %16, i64* %14, align 8, !dbg !99, !tbaa !100
  %17 = getelementptr inbounds i8, i8* %8, i64 8, !dbg !103
  %18 = bitcast i8* %17 to i64*, !dbg !103
  %19 = load i64, i64* %18, align 8, !dbg !104, !tbaa !105
  %20 = add i64 %13, %19, !dbg !104
  store i64 %20, i64* %18, align 8, !dbg !104, !tbaa !105
  %21 = load i32, i32* %2, align 4, !dbg !106, !tbaa !82
  call void @llvm.dbg.value(metadata i32 %21, metadata !68, metadata !DIExpression()) #3, !dbg !62
  br label %22

22:                                               ; preds = %1, %10
  %23 = phi i32 [ %21, %10 ], [ 0, %1 ], !dbg !62
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3), !dbg !107
  ret i32 %23, !dbg !108
}

; Function Attrs: nounwind
define dso_local i32 @xdp_drop_func(%struct.xdp_md* nocapture readonly %0) #0 section "xdp_drop" !dbg !109 {
  %2 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !111, metadata !DIExpression()), !dbg !113
  call void @llvm.dbg.value(metadata i32 1, metadata !112, metadata !DIExpression()), !dbg !113
  %3 = bitcast i32* %2 to i8*, !dbg !114
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %3), !dbg !114
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !67, metadata !DIExpression()) #3, !dbg !114
  call void @llvm.dbg.value(metadata i32 1, metadata !68, metadata !DIExpression()) #3, !dbg !114
  store i32 1, i32* %2, align 4, !tbaa !82
  %4 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !116
  %5 = load i32, i32* %4, align 4, !dbg !116, !tbaa !87
  call void @llvm.dbg.value(metadata i32 %5, metadata !69, metadata !DIExpression()) #3, !dbg !114
  %6 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !117
  %7 = load i32, i32* %6, align 4, !dbg !117, !tbaa !90
  call void @llvm.dbg.value(metadata i32 %7, metadata !70, metadata !DIExpression()) #3, !dbg !114
  call void @llvm.dbg.value(metadata i32* %2, metadata !68, metadata !DIExpression(DW_OP_deref)) #3, !dbg !114
  %8 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* nonnull %3) #3, !dbg !118
  call void @llvm.dbg.value(metadata i8* %8, metadata !71, metadata !DIExpression()) #3, !dbg !114
  %9 = icmp eq i8* %8, null, !dbg !119
  br i1 %9, label %22, label %10, !dbg !120

10:                                               ; preds = %1
  %11 = zext i32 %7 to i64, !dbg !121
  call void @llvm.dbg.value(metadata i64 %11, metadata !70, metadata !DIExpression()) #3, !dbg !114
  %12 = zext i32 %5 to i64, !dbg !122
  call void @llvm.dbg.value(metadata i64 %12, metadata !69, metadata !DIExpression()) #3, !dbg !114
  call void @llvm.dbg.value(metadata i8* %8, metadata !71, metadata !DIExpression()) #3, !dbg !114
  %13 = sub nsw i64 %12, %11, !dbg !123
  call void @llvm.dbg.value(metadata i64 %13, metadata !80, metadata !DIExpression()) #3, !dbg !114
  %14 = bitcast i8* %8 to i64*, !dbg !124
  %15 = load i64, i64* %14, align 8, !dbg !125, !tbaa !100
  %16 = add i64 %15, 1, !dbg !125
  store i64 %16, i64* %14, align 8, !dbg !125, !tbaa !100
  %17 = getelementptr inbounds i8, i8* %8, i64 8, !dbg !126
  %18 = bitcast i8* %17 to i64*, !dbg !126
  %19 = load i64, i64* %18, align 8, !dbg !127, !tbaa !105
  %20 = add i64 %13, %19, !dbg !127
  store i64 %20, i64* %18, align 8, !dbg !127, !tbaa !105
  %21 = load i32, i32* %2, align 4, !dbg !128, !tbaa !82
  call void @llvm.dbg.value(metadata i32 %21, metadata !68, metadata !DIExpression()) #3, !dbg !114
  br label %22

22:                                               ; preds = %1, %10
  %23 = phi i32 [ %21, %10 ], [ 0, %1 ], !dbg !114
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3), !dbg !129
  ret i32 %23, !dbg !130
}

; Function Attrs: nounwind
define dso_local i32 @xdp_abort_func(%struct.xdp_md* nocapture readonly %0) #0 section "xdp_abort" !dbg !131 {
  %2 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !133, metadata !DIExpression()), !dbg !135
  call void @llvm.dbg.value(metadata i32 0, metadata !134, metadata !DIExpression()), !dbg !135
  %3 = bitcast i32* %2 to i8*, !dbg !136
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %3), !dbg !136
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !67, metadata !DIExpression()) #3, !dbg !136
  call void @llvm.dbg.value(metadata i32 0, metadata !68, metadata !DIExpression()) #3, !dbg !136
  store i32 0, i32* %2, align 4, !tbaa !82
  %4 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !138
  %5 = load i32, i32* %4, align 4, !dbg !138, !tbaa !87
  call void @llvm.dbg.value(metadata i32 %5, metadata !69, metadata !DIExpression()) #3, !dbg !136
  %6 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !139
  %7 = load i32, i32* %6, align 4, !dbg !139, !tbaa !90
  call void @llvm.dbg.value(metadata i32 %7, metadata !70, metadata !DIExpression()) #3, !dbg !136
  call void @llvm.dbg.value(metadata i32* %2, metadata !68, metadata !DIExpression(DW_OP_deref)) #3, !dbg !136
  %8 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* nonnull %3) #3, !dbg !140
  call void @llvm.dbg.value(metadata i8* %8, metadata !71, metadata !DIExpression()) #3, !dbg !136
  %9 = icmp eq i8* %8, null, !dbg !141
  br i1 %9, label %22, label %10, !dbg !142

10:                                               ; preds = %1
  %11 = zext i32 %7 to i64, !dbg !143
  call void @llvm.dbg.value(metadata i64 %11, metadata !70, metadata !DIExpression()) #3, !dbg !136
  %12 = zext i32 %5 to i64, !dbg !144
  call void @llvm.dbg.value(metadata i64 %12, metadata !69, metadata !DIExpression()) #3, !dbg !136
  call void @llvm.dbg.value(metadata i8* %8, metadata !71, metadata !DIExpression()) #3, !dbg !136
  %13 = sub nsw i64 %12, %11, !dbg !145
  call void @llvm.dbg.value(metadata i64 %13, metadata !80, metadata !DIExpression()) #3, !dbg !136
  %14 = bitcast i8* %8 to i64*, !dbg !146
  %15 = load i64, i64* %14, align 8, !dbg !147, !tbaa !100
  %16 = add i64 %15, 1, !dbg !147
  store i64 %16, i64* %14, align 8, !dbg !147, !tbaa !100
  %17 = getelementptr inbounds i8, i8* %8, i64 8, !dbg !148
  %18 = bitcast i8* %17 to i64*, !dbg !148
  %19 = load i64, i64* %18, align 8, !dbg !149, !tbaa !105
  %20 = add i64 %13, %19, !dbg !149
  store i64 %20, i64* %18, align 8, !dbg !149, !tbaa !105
  %21 = load i32, i32* %2, align 4, !dbg !150, !tbaa !82
  call void @llvm.dbg.value(metadata i32 %21, metadata !68, metadata !DIExpression()) #3, !dbg !136
  br label %22

22:                                               ; preds = %1, %10
  %23 = phi i32 [ %21, %10 ], [ 0, %1 ], !dbg !136
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %3), !dbg !151
  ret i32 %23, !dbg !152
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nounwind willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!40, !41, !42}
!llvm.ident = !{!43}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !3, line: 11, type: !32, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !14, globals: !17, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "xdp_prog_kern.c", directory: "/mnt/d/xdp-tutorial/basic04-pinning-maps")
!4 = !{!5}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 2845, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "../headers/linux/bpf.h", directory: "/mnt/d/xdp-tutorial/basic04-pinning-maps")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0, isUnsigned: true)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1, isUnsigned: true)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2, isUnsigned: true)
!12 = !DIEnumerator(name: "XDP_TX", value: 3, isUnsigned: true)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4, isUnsigned: true)
!14 = !{!15, !16}
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!16 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!17 = !{!0, !18, !24}
!18 = !DIGlobalVariableExpression(var: !19, expr: !DIExpression())
!19 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 76, type: !20, isLocal: false, isDefinition: true)
!20 = !DICompositeType(tag: DW_TAG_array_type, baseType: !21, size: 32, elements: !22)
!21 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!22 = !{!23}
!23 = !DISubrange(count: 4)
!24 = !DIGlobalVariableExpression(var: !25, expr: !DIExpression())
!25 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !26, line: 33, type: !27, isLocal: true, isDefinition: true)
!26 = !DIFile(filename: "../libbpf/src//build/usr/include/bpf/bpf_helper_defs.h", directory: "/mnt/d/xdp-tutorial/basic04-pinning-maps")
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!28 = !DISubroutineType(types: !29)
!29 = !{!15, !15, !30}
!30 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !31, size: 64)
!31 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!32 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_map_def", file: !33, line: 33, size: 160, elements: !34)
!33 = !DIFile(filename: "../libbpf/src//build/usr/include/bpf/bpf_helpers.h", directory: "/mnt/d/xdp-tutorial/basic04-pinning-maps")
!34 = !{!35, !36, !37, !38, !39}
!35 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !32, file: !33, line: 34, baseType: !7, size: 32)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !32, file: !33, line: 35, baseType: !7, size: 32, offset: 32)
!37 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !32, file: !33, line: 36, baseType: !7, size: 32, offset: 64)
!38 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !32, file: !33, line: 37, baseType: !7, size: 32, offset: 96)
!39 = !DIDerivedType(tag: DW_TAG_member, name: "map_flags", scope: !32, file: !33, line: 38, baseType: !7, size: 32, offset: 128)
!40 = !{i32 7, !"Dwarf Version", i32 4}
!41 = !{i32 2, !"Debug Info Version", i32 3}
!42 = !{i32 1, !"wchar_size", i32 4}
!43 = !{!"clang version 10.0.0-4ubuntu1 "}
!44 = distinct !DISubprogram(name: "xdp_pass_func", scope: !3, file: !3, line: 53, type: !45, scopeLine: 54, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !58)
!45 = !DISubroutineType(types: !46)
!46 = !{!47, !48}
!47 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!48 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !49, size: 64)
!49 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 2856, size: 160, elements: !50)
!50 = !{!51, !54, !55, !56, !57}
!51 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !49, file: !6, line: 2857, baseType: !52, size: 32)
!52 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !53, line: 27, baseType: !7)
!53 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!54 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !49, file: !6, line: 2858, baseType: !52, size: 32, offset: 32)
!55 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !49, file: !6, line: 2859, baseType: !52, size: 32, offset: 64)
!56 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !49, file: !6, line: 2861, baseType: !52, size: 32, offset: 96)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !49, file: !6, line: 2862, baseType: !52, size: 32, offset: 128)
!58 = !{!59, !60}
!59 = !DILocalVariable(name: "ctx", arg: 1, scope: !44, file: !3, line: 53, type: !48)
!60 = !DILocalVariable(name: "action", scope: !44, file: !3, line: 55, type: !52)
!61 = !DILocation(line: 0, scope: !44)
!62 = !DILocation(line: 0, scope: !63, inlinedAt: !81)
!63 = distinct !DISubprogram(name: "xdp_stats_record_action", scope: !3, file: !3, line: 26, type: !64, scopeLine: 27, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !66)
!64 = !DISubroutineType(types: !65)
!65 = !{!52, !48, !52}
!66 = !{!67, !68, !69, !70, !71, !80}
!67 = !DILocalVariable(name: "ctx", arg: 1, scope: !63, file: !3, line: 26, type: !48)
!68 = !DILocalVariable(name: "action", arg: 2, scope: !63, file: !3, line: 26, type: !52)
!69 = !DILocalVariable(name: "data_end", scope: !63, file: !3, line: 28, type: !15)
!70 = !DILocalVariable(name: "data", scope: !63, file: !3, line: 29, type: !15)
!71 = !DILocalVariable(name: "rec", scope: !63, file: !3, line: 35, type: !72)
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !73, size: 64)
!73 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "datarec", file: !74, line: 8, size: 128, elements: !75)
!74 = !DIFile(filename: "./common_kern_user.h", directory: "/mnt/d/xdp-tutorial/basic04-pinning-maps")
!75 = !{!76, !79}
!76 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !73, file: !74, line: 9, baseType: !77, size: 64)
!77 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !53, line: 31, baseType: !78)
!78 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "rx_bytes", scope: !73, file: !74, line: 10, baseType: !77, size: 64, offset: 64)
!80 = !DILocalVariable(name: "bytes", scope: !63, file: !3, line: 40, type: !77)
!81 = distinct !DILocation(line: 57, column: 9, scope: !44)
!82 = !{!83, !83, i64 0}
!83 = !{!"int", !84, i64 0}
!84 = !{!"omnipotent char", !85, i64 0}
!85 = !{!"Simple C/C++ TBAA"}
!86 = !DILocation(line: 28, column: 38, scope: !63, inlinedAt: !81)
!87 = !{!88, !83, i64 4}
!88 = !{!"xdp_md", !83, i64 0, !83, i64 4, !83, i64 8, !83, i64 12, !83, i64 16}
!89 = !DILocation(line: 29, column: 38, scope: !63, inlinedAt: !81)
!90 = !{!88, !83, i64 0}
!91 = !DILocation(line: 35, column: 24, scope: !63, inlinedAt: !81)
!92 = !DILocation(line: 36, column: 7, scope: !93, inlinedAt: !81)
!93 = distinct !DILexicalBlock(scope: !63, file: !3, line: 36, column: 6)
!94 = !DILocation(line: 36, column: 6, scope: !63, inlinedAt: !81)
!95 = !DILocation(line: 29, column: 27, scope: !63, inlinedAt: !81)
!96 = !DILocation(line: 28, column: 27, scope: !63, inlinedAt: !81)
!97 = !DILocation(line: 40, column: 25, scope: !63, inlinedAt: !81)
!98 = !DILocation(line: 46, column: 7, scope: !63, inlinedAt: !81)
!99 = !DILocation(line: 46, column: 17, scope: !63, inlinedAt: !81)
!100 = !{!101, !102, i64 0}
!101 = !{!"datarec", !102, i64 0, !102, i64 8}
!102 = !{!"long long", !84, i64 0}
!103 = !DILocation(line: 47, column: 7, scope: !63, inlinedAt: !81)
!104 = !DILocation(line: 47, column: 16, scope: !63, inlinedAt: !81)
!105 = !{!101, !102, i64 8}
!106 = !DILocation(line: 49, column: 9, scope: !63, inlinedAt: !81)
!107 = !DILocation(line: 50, column: 1, scope: !63, inlinedAt: !81)
!108 = !DILocation(line: 57, column: 2, scope: !44)
!109 = distinct !DISubprogram(name: "xdp_drop_func", scope: !3, file: !3, line: 61, type: !45, scopeLine: 62, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !110)
!110 = !{!111, !112}
!111 = !DILocalVariable(name: "ctx", arg: 1, scope: !109, file: !3, line: 61, type: !48)
!112 = !DILocalVariable(name: "action", scope: !109, file: !3, line: 63, type: !52)
!113 = !DILocation(line: 0, scope: !109)
!114 = !DILocation(line: 0, scope: !63, inlinedAt: !115)
!115 = distinct !DILocation(line: 65, column: 9, scope: !109)
!116 = !DILocation(line: 28, column: 38, scope: !63, inlinedAt: !115)
!117 = !DILocation(line: 29, column: 38, scope: !63, inlinedAt: !115)
!118 = !DILocation(line: 35, column: 24, scope: !63, inlinedAt: !115)
!119 = !DILocation(line: 36, column: 7, scope: !93, inlinedAt: !115)
!120 = !DILocation(line: 36, column: 6, scope: !63, inlinedAt: !115)
!121 = !DILocation(line: 29, column: 27, scope: !63, inlinedAt: !115)
!122 = !DILocation(line: 28, column: 27, scope: !63, inlinedAt: !115)
!123 = !DILocation(line: 40, column: 25, scope: !63, inlinedAt: !115)
!124 = !DILocation(line: 46, column: 7, scope: !63, inlinedAt: !115)
!125 = !DILocation(line: 46, column: 17, scope: !63, inlinedAt: !115)
!126 = !DILocation(line: 47, column: 7, scope: !63, inlinedAt: !115)
!127 = !DILocation(line: 47, column: 16, scope: !63, inlinedAt: !115)
!128 = !DILocation(line: 49, column: 9, scope: !63, inlinedAt: !115)
!129 = !DILocation(line: 50, column: 1, scope: !63, inlinedAt: !115)
!130 = !DILocation(line: 65, column: 2, scope: !109)
!131 = distinct !DISubprogram(name: "xdp_abort_func", scope: !3, file: !3, line: 69, type: !45, scopeLine: 70, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !132)
!132 = !{!133, !134}
!133 = !DILocalVariable(name: "ctx", arg: 1, scope: !131, file: !3, line: 69, type: !48)
!134 = !DILocalVariable(name: "action", scope: !131, file: !3, line: 71, type: !52)
!135 = !DILocation(line: 0, scope: !131)
!136 = !DILocation(line: 0, scope: !63, inlinedAt: !137)
!137 = distinct !DILocation(line: 73, column: 9, scope: !131)
!138 = !DILocation(line: 28, column: 38, scope: !63, inlinedAt: !137)
!139 = !DILocation(line: 29, column: 38, scope: !63, inlinedAt: !137)
!140 = !DILocation(line: 35, column: 24, scope: !63, inlinedAt: !137)
!141 = !DILocation(line: 36, column: 7, scope: !93, inlinedAt: !137)
!142 = !DILocation(line: 36, column: 6, scope: !63, inlinedAt: !137)
!143 = !DILocation(line: 29, column: 27, scope: !63, inlinedAt: !137)
!144 = !DILocation(line: 28, column: 27, scope: !63, inlinedAt: !137)
!145 = !DILocation(line: 40, column: 25, scope: !63, inlinedAt: !137)
!146 = !DILocation(line: 46, column: 7, scope: !63, inlinedAt: !137)
!147 = !DILocation(line: 46, column: 17, scope: !63, inlinedAt: !137)
!148 = !DILocation(line: 47, column: 7, scope: !63, inlinedAt: !137)
!149 = !DILocation(line: 47, column: 16, scope: !63, inlinedAt: !137)
!150 = !DILocation(line: 49, column: 9, scope: !63, inlinedAt: !137)
!151 = !DILocation(line: 50, column: 1, scope: !63, inlinedAt: !137)
!152 = !DILocation(line: 73, column: 2, scope: !131)
