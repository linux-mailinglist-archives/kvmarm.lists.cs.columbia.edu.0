Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 571CA630882
	for <lists+kvmarm@lfdr.de>; Sat, 19 Nov 2022 02:35:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CA00C4BB60;
	Fri, 18 Nov 2022 20:35:06 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.787
X-Spam-Level: 
X-Spam-Status: No, score=-1.787 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	RCVD_IN_DNSWL_BLOCKED=0.001, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 39Yt2C8tz39v; Fri, 18 Nov 2022 20:35:05 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1CA434B64F;
	Fri, 18 Nov 2022 20:35:05 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C39B34BB52
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Nov 2022 20:35:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kn1wQLS5jo8X for <kvmarm@lists.cs.columbia.edu>;
 Fri, 18 Nov 2022 20:35:02 -0500 (EST)
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com
 [209.85.216.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id BF0814BB62
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Nov 2022 20:35:01 -0500 (EST)
Received: by mail-pj1-f73.google.com with SMTP id
 a23-20020a17090a8c1700b0021890040f7cso1539513pjo.1
 for <kvmarm@lists.cs.columbia.edu>; Fri, 18 Nov 2022 17:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
 bh=jYDJ9XgbSK1d9HoZtCqk9N73DkrhQlQprGuYiT+qPlM=;
 b=kwFBcPJnGMlsB/29xUFzZq4VtMmnBsyX5OzE/1svd9gRnfU6LLzcF8t37X2NNG32t1
 Bgc27WpG66hJDzm6l54eNYoWaB+FNHXVRtLV2NDHKYE4SJtlxEx3h4v1cvI217WS0o7C
 jEV3CYYrVQisgSWUCo5d/nroZBQrF5pKsbVhzGgnVzRopuOSiTQotgtU5JUDLjQNeu+2
 WVZaskUzUJ2o8K5kS/S/9VeOhGlOFUXX9CpZcV1ZWBZ6cgVMHPlTmal6kXHv+6fIVROR
 AvfeWIQ4ZhSYnnykMBYHDmA0gsIuaE5lHLPpGvXR3EAFTCxxOTA0afV+Xvc9wrGpXqUf
 apsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jYDJ9XgbSK1d9HoZtCqk9N73DkrhQlQprGuYiT+qPlM=;
 b=vjRBWOO+GkVky4/azIvkHBLhy4c0kBsaK4x1gEKEVWZObHmMWiDi4THpcpXq7nuMc7
 hgpjruMjUzwLU7cmVsDc36b3VAXvAXfwrD7TF7Z+BFIqjBSsPuUuJTvpZyEDP1m5w3aA
 KyCZOyaSEj1YDkJltEvQCQa7+4m4+38irpMxwss3kEHLyDFxoltUX/NtiJ89GDbeo4fo
 z95VFeTFwogELBqP+3/bUkSP1LtpC9zf6ghDt8r2ho1qOb6+P8saE9tZrTH0cPF4Y7Jr
 zSXyA2Q72SPUjq2s00vd0Xi7AAouGbbd7fUyqYQBoEp1QV7D/aEUG2dK33bRFX00JMss
 Xz+Q==
X-Gm-Message-State: ANoB5plT2iqiI4A3A82VHG6hoXIwbFq2heMVWjC2F4ly7rVy+6WQ8u0l
 /c6FRX5oPZOrYjtBiJUCBHpdfei29JU=
X-Google-Smtp-Source: AA0mqf58GhlIRj68viRDbHyf8r7RevulGOfjuPacei8aNDHQ4OT1GGFQfYh51TiZf6mEV3JWhy88V5y1SgM=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:3241:b0:186:dcc3:5d1d with SMTP id
 ji1-20020a170903324100b00186dcc35d1dmr2180824plb.20.1668821701443; Fri, 18
 Nov 2022 17:35:01 -0800 (PST)
Date: Sat, 19 Nov 2022 01:34:46 +0000
In-Reply-To: <20221119013450.2643007-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221119013450.2643007-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221119013450.2643007-6-seanjc@google.com>
Subject: [PATCH 5/9] perf tools: Use dedicated non-atomic clear/set bit helpers
From: Sean Christopherson <seanjc@google.com>
To: Yury Norov <yury.norov@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
 kvmarm@lists.linux.dev, Namhyung Kim <namhyung@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Sean Christopherson <seanjc@google.com>
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Use the dedicated non-atomic helpers for {clear,set}_bit() and their
test variants, i.e. the double-underscore versions.  Depsite being
defined in atomic.h, and despite the kernel versions being atomic in the
kernel, tools' {clear,set}_bit() helpers aren't actually atomic.  Move
to the double-underscore versions so that the versions that are expected
to be atomic (for kernel developers) can be made atomic without affecting
users that don't want atomic operations.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/perf/bench/find-bit-bench.c                      | 2 +-
 tools/perf/builtin-c2c.c                               | 6 +++---
 tools/perf/builtin-kwork.c                             | 6 +++---
 tools/perf/builtin-record.c                            | 6 +++---
 tools/perf/builtin-sched.c                             | 2 +-
 tools/perf/tests/bitmap.c                              | 2 +-
 tools/perf/tests/mem2node.c                            | 2 +-
 tools/perf/util/affinity.c                             | 4 ++--
 tools/perf/util/header.c                               | 8 ++++----
 tools/perf/util/mmap.c                                 | 6 +++---
 tools/perf/util/pmu.c                                  | 2 +-
 tools/perf/util/scripting-engines/trace-event-perl.c   | 2 +-
 tools/perf/util/scripting-engines/trace-event-python.c | 2 +-
 tools/perf/util/session.c                              | 2 +-
 tools/perf/util/svghelper.c                            | 2 +-
 15 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
index 22b5cfe97023..d103c3136983 100644
--- a/tools/perf/bench/find-bit-bench.c
+++ b/tools/perf/bench/find-bit-bench.c
@@ -70,7 +70,7 @@ static int do_for_each_set_bit(unsigned int num_bits)
 		bitmap_zero(to_test, num_bits);
 		skip = num_bits / set_bits;
 		for (i = 0; i < num_bits; i += skip)
-			set_bit(i, to_test);
+			__set_bit(i, to_test);
 
 		for (i = 0; i < outer_iterations; i++) {
 			old = accumulator;
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index a9190458d2d5..52d94c7dd836 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -230,7 +230,7 @@ static void c2c_he__set_cpu(struct c2c_hist_entry *c2c_he,
 		      "WARNING: no sample cpu value"))
 		return;
 
-	set_bit(sample->cpu, c2c_he->cpuset);
+	__set_bit(sample->cpu, c2c_he->cpuset);
 }
 
 static void c2c_he__set_node(struct c2c_hist_entry *c2c_he,
@@ -247,7 +247,7 @@ static void c2c_he__set_node(struct c2c_hist_entry *c2c_he,
 	if (WARN_ONCE(node < 0, "WARNING: failed to find node\n"))
 		return;
 
-	set_bit(node, c2c_he->nodeset);
+	__set_bit(node, c2c_he->nodeset);
 
 	if (c2c_he->paddr != sample->phys_addr) {
 		c2c_he->paddr_cnt++;
@@ -2318,7 +2318,7 @@ static int setup_nodes(struct perf_session *session)
 			continue;
 
 		perf_cpu_map__for_each_cpu(cpu, idx, map) {
-			set_bit(cpu.cpu, set);
+			__set_bit(cpu.cpu, set);
 
 			if (WARN_ONCE(cpu2node[cpu.cpu] != -1, "node/cpu topology bug"))
 				return -EINVAL;
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index fb8c63656ad8..1f63e24f704e 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -216,7 +216,7 @@ static struct kwork_atom *atom_new(struct perf_kwork *kwork,
 	list_add_tail(&page->list, &kwork->atom_page_list);
 
 found_atom:
-	set_bit(i, page->bitmap);
+	__set_bit(i, page->bitmap);
 	atom->time = sample->time;
 	atom->prev = NULL;
 	atom->page_addr = page;
@@ -229,8 +229,8 @@ static void atom_free(struct kwork_atom *atom)
 	if (atom->prev != NULL)
 		atom_free(atom->prev);
 
-	clear_bit(atom->bit_inpage,
-		  ((struct kwork_atom_page *)atom->page_addr)->bitmap);
+	__clear_bit(atom->bit_inpage,
+		    ((struct kwork_atom_page *)atom->page_addr)->bitmap);
 }
 
 static void atom_del(struct kwork_atom *atom)
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e128b855ddde..2711c141c5bf 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3555,7 +3555,7 @@ static int record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cp
 		/* Return ENODEV is input cpu is greater than max cpu */
 		if ((unsigned long)cpu.cpu > mask->nbits)
 			return -ENODEV;
-		set_bit(cpu.cpu, mask->bits);
+		__set_bit(cpu.cpu, mask->bits);
 	}
 
 	return 0;
@@ -3627,8 +3627,8 @@ static int record__init_thread_cpu_masks(struct record *rec, struct perf_cpu_map
 	pr_debug("nr_threads: %d\n", rec->nr_threads);
 
 	for (t = 0; t < rec->nr_threads; t++) {
-		set_bit(perf_cpu_map__cpu(cpus, t).cpu, rec->thread_masks[t].maps.bits);
-		set_bit(perf_cpu_map__cpu(cpus, t).cpu, rec->thread_masks[t].affinity.bits);
+		__set_bit(perf_cpu_map__cpu(cpus, t).cpu, rec->thread_masks[t].maps.bits);
+		__set_bit(perf_cpu_map__cpu(cpus, t).cpu, rec->thread_masks[t].affinity.bits);
 		if (verbose) {
 			pr_debug("thread_masks[%d]: ", t);
 			mmap_cpu_mask__scnprintf(&rec->thread_masks[t].maps, "maps");
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index f93737eef07b..86e18575c9be 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1573,7 +1573,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 
 	if (sched->map.comp) {
 		cpus_nr = bitmap_weight(sched->map.comp_cpus_mask, MAX_CPUS);
-		if (!test_and_set_bit(this_cpu.cpu, sched->map.comp_cpus_mask)) {
+		if (!__test_and_set_bit(this_cpu.cpu, sched->map.comp_cpus_mask)) {
 			sched->map.comp_cpus[cpus_nr++] = this_cpu;
 			new_cpu = true;
 		}
diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
index 4965dd666956..0173f5402a35 100644
--- a/tools/perf/tests/bitmap.c
+++ b/tools/perf/tests/bitmap.c
@@ -18,7 +18,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 
 	if (map && bm) {
 		for (i = 0; i < perf_cpu_map__nr(map); i++)
-			set_bit(perf_cpu_map__cpu(map, i).cpu, bm);
+			__set_bit(perf_cpu_map__cpu(map, i).cpu, bm);
 	}
 
 	if (map)
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
index 4c96829510c9..a0e88c496107 100644
--- a/tools/perf/tests/mem2node.c
+++ b/tools/perf/tests/mem2node.c
@@ -33,7 +33,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 		int i;
 
 		perf_cpu_map__for_each_cpu(cpu, i, map)
-			set_bit(cpu.cpu, bm);
+			__set_bit(cpu.cpu, bm);
 	}
 
 	if (map)
diff --git a/tools/perf/util/affinity.c b/tools/perf/util/affinity.c
index 4ee96b3c755b..38dc4524b7e8 100644
--- a/tools/perf/util/affinity.c
+++ b/tools/perf/util/affinity.c
@@ -58,14 +58,14 @@ void affinity__set(struct affinity *a, int cpu)
 		return;
 
 	a->changed = true;
-	set_bit(cpu, a->sched_cpus);
+	__set_bit(cpu, a->sched_cpus);
 	/*
 	 * We ignore errors because affinity is just an optimization.
 	 * This could happen for example with isolated CPUs or cpusets.
 	 * In this case the IPIs inside the kernel's perf API still work.
 	 */
 	sched_setaffinity(0, cpu_set_size, (cpu_set_t *)a->sched_cpus);
-	clear_bit(cpu, a->sched_cpus);
+	__clear_bit(cpu, a->sched_cpus);
 }
 
 static void __affinity__cleanup(struct affinity *a)
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 98dfaf84bd13..dc2ae397d400 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -79,12 +79,12 @@ struct perf_file_attr {
 
 void perf_header__set_feat(struct perf_header *header, int feat)
 {
-	set_bit(feat, header->adds_features);
+	__set_bit(feat, header->adds_features);
 }
 
 void perf_header__clear_feat(struct perf_header *header, int feat)
 {
-	clear_bit(feat, header->adds_features);
+	__clear_bit(feat, header->adds_features);
 }
 
 bool perf_header__has_feat(const struct perf_header *header, int feat)
@@ -1358,7 +1358,7 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
 	rewinddir(dir);
 
 	for_each_memory(phys, dir) {
-		set_bit(phys, n->set);
+		__set_bit(phys, n->set);
 	}
 
 	closedir(dir);
@@ -3952,7 +3952,7 @@ int perf_file_header__read(struct perf_file_header *header,
 
 		if (!test_bit(HEADER_HOSTNAME, header->adds_features)) {
 			bitmap_zero(header->adds_features, HEADER_FEAT_BITS);
-			set_bit(HEADER_BUILD_ID, header->adds_features);
+			__set_bit(HEADER_BUILD_ID, header->adds_features);
 		}
 	}
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index a4dff881be39..49093b21ee2d 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -111,7 +111,7 @@ static int perf_mmap__aio_bind(struct mmap *map, int idx, struct perf_cpu cpu, i
 			pr_err("Failed to allocate node mask for mbind: error %m\n");
 			return -1;
 		}
-		set_bit(node_index, node_mask);
+		__set_bit(node_index, node_mask);
 		if (mbind(data, mmap_len, MPOL_BIND, node_mask, node_index + 1 + 1, 0)) {
 			pr_err("Failed to bind [%p-%p] AIO buffer to node %lu: error %m\n",
 				data, data + mmap_len, node_index);
@@ -256,7 +256,7 @@ static void build_node_mask(int node, struct mmap_cpu_mask *mask)
 	for (idx = 0; idx < nr_cpus; idx++) {
 		cpu = perf_cpu_map__cpu(cpu_map, idx); /* map c index to online cpu index */
 		if (cpu__get_node(cpu) == node)
-			set_bit(cpu.cpu, mask->bits);
+			__set_bit(cpu.cpu, mask->bits);
 	}
 }
 
@@ -270,7 +270,7 @@ static int perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *
 	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1)
 		build_node_mask(cpu__get_node(map->core.cpu), &map->affinity_mask);
 	else if (mp->affinity == PERF_AFFINITY_CPU)
-		set_bit(map->core.cpu.cpu, map->affinity_mask.bits);
+		__set_bit(map->core.cpu.cpu, map->affinity_mask.bits);
 
 	return 0;
 }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 03284059175f..371d8f7a3de3 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1513,7 +1513,7 @@ void perf_pmu__set_format(unsigned long *bits, long from, long to)
 
 	memset(bits, 0, BITS_TO_BYTES(PERF_PMU_FORMAT_BITS));
 	for (b = from; b <= to; b++)
-		set_bit(b, bits);
+		__set_bit(b, bits);
 }
 
 void perf_pmu__del_formats(struct list_head *formats)
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index a5d945415bbc..5b602b6d4685 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -365,7 +365,7 @@ static void perl_process_tracepoint(struct perf_sample *sample,
 
 	sprintf(handler, "%s::%s", event->system, event->name);
 
-	if (!test_and_set_bit(event->id, events_defined))
+	if (!__test_and_set_bit(event->id, events_defined))
 		define_event_symbols(event, handler, event->print_fmt.args);
 
 	s = nsecs / NSEC_PER_SEC;
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 1f2040f36d4e..0f229fa29163 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -933,7 +933,7 @@ static void python_process_tracepoint(struct perf_sample *sample,
 
 	sprintf(handler_name, "%s__%s", event->system, event->name);
 
-	if (!test_and_set_bit(event->id, events_defined))
+	if (!__test_and_set_bit(event->id, events_defined))
 		define_event_symbols(event, handler_name, event->print_fmt.args);
 
 	handler = get_handler(handler_name);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 1a4f10de29ff..873fd51ec1b2 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2748,7 +2748,7 @@ int perf_session__cpu_bitmap(struct perf_session *session,
 			goto out_delete_map;
 		}
 
-		set_bit(cpu.cpu, cpu_bitmap);
+		__set_bit(cpu.cpu, cpu_bitmap);
 	}
 
 	err = 0;
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 1e0c731fc539..5c62d3118c41 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -741,7 +741,7 @@ static int str_to_bitmap(char *s, cpumask_t *b, int nr_cpus)
 			break;
 		}
 
-		set_bit(c.cpu, cpumask_bits(b));
+		__set_bit(c.cpu, cpumask_bits(b));
 	}
 
 	perf_cpu_map__put(m);
-- 
2.38.1.584.g0f3c55d4c2-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
