Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 851A6360E92
	for <lists+kvmarm@lfdr.de>; Thu, 15 Apr 2021 17:18:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 261044B724;
	Thu, 15 Apr 2021 11:18:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i7SXOnWhCVB2; Thu, 15 Apr 2021 11:18:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7338E4B72B;
	Thu, 15 Apr 2021 11:17:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 846644B6B3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Apr 2021 11:17:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 097IdJ-f0S-N for <kvmarm@lists.cs.columbia.edu>;
 Thu, 15 Apr 2021 11:17:54 -0400 (EDT)
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com
 [209.85.216.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 299E24B6EF
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Apr 2021 11:17:52 -0400 (EDT)
Received: by mail-pj1-f73.google.com with SMTP id
 ha8-20020a17090af3c8b029014de244c4f9so12197268pjb.9
 for <kvmarm@lists.cs.columbia.edu>; Thu, 15 Apr 2021 08:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=0LO6oJg1J/PSbt/I1DJNWKL6xWFnsibne8UGI7p/X7U=;
 b=Mxcuusbsyo3Hl7tLG2sqa6ebs88NwSJ47Ssw0ntnprM1yBUVQTYoGiYaT7IVcN8enV
 Et7Heq4PwuGsI4sU4wtvBKP0RU8RETkruYd8jp3wxMeEX3Rrh4FRkXaNL6Mp+0+loAGY
 VOK4KMSLZROyyT71mB4atCNV1zgjB9z6R7NB0dR7rTTV7AeB6OTX+gYJ81BgZ3jfvbxv
 YxM4vqy2JbWTvfTLZCfqqaSEkZSpq5HLFQCVLgi9yXI2Imc+aObITAsQTUkQKusGf1SX
 PcQvltSBhN5/S5oM+O8OeYNUCQL2oftlq5fiVpfrFRWPhwiYJktSRAUb9geOOfrcGEDY
 EW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=0LO6oJg1J/PSbt/I1DJNWKL6xWFnsibne8UGI7p/X7U=;
 b=G1cULEXnc74jzO3w6ovImxMQkz7075hpD5dw86pYJPBBiV1MfMnIgDBjGurd8Owqri
 LVxTDRNGgELo48SFtPh258/I7YJzRJu1KXouOb4WV6Z5PpyqD6HbxXMqVqJYns2O7A7S
 RzXKboGLyOVxioJ2wVD0N0q5fB3xvIY8aSNFXR9kAf7nH8J6LYRUnJ+haApm7NVMxFfA
 qqv1UJ8Lop1+ERZ2ulxqx5brNFCFeVZTFytlkDs0RDZQNRnelNbm0MLYU/vaj86sbjbX
 Hblp2a7SvD4FaW2VIxlbUf0ID1sBtcu0h5ppD26y4XfG78nnySivhrSbKrvkK3ng9Xj8
 fyoQ==
X-Gm-Message-State: AOAM5339P3CxSyRW43S8ngQA63+esxkT8FS2lK/Q4rTVIDWLWXFH0fes
 iiEqXcsigUubcoS1KRPimw0ZoCf/UxDuu9NX0Q==
X-Google-Smtp-Source: ABdhPJwino7iFjPKYYpune4AXyYUAIecsYG/l/m+KwgdSssG8W9x6U3tXbrfRzAa5LUdbWxs4Db0400ixbOyeMTLsw==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:a17:90a:bf84:: with SMTP id
 d4mr4390986pjs.118.1618499871205; Thu, 15 Apr 2021 08:17:51 -0700 (PDT)
Date: Thu, 15 Apr 2021 15:17:41 +0000
In-Reply-To: <20210415151741.1607806-1-jingzhangos@google.com>
Message-Id: <20210415151741.1607806-5-jingzhangos@google.com>
Mime-Version: 1.0
References: <20210415151741.1607806-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v2 4/4] KVM: selftests: Add selftest for KVM statistics data
 binary interface
From: Jing Zhang <jingzhangos@google.com>
To: KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>, 
 LinuxMIPS <linux-mips@vger.kernel.org>, KVMPPC <kvm-ppc@vger.kernel.org>, 
 LinuxS390 <linux-s390@vger.kernel.org>, 
 Linuxkselftest <linux-kselftest@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Paul Mackerras <paulus@ozlabs.org>, 
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, 
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Sean Christopherson <seanjc@google.com>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, Jim Mattson <jmattson@google.com>, 
 Peter Shier <pshier@google.com>, Oliver Upton <oupton@google.com>, 
 David Rientjes <rientjes@google.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
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

Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 .../testing/selftests/kvm/include/kvm_util.h  |   3 +
 .../selftests/kvm/kvm_bin_form_stats.c        | 370 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  11 +
 5 files changed, 388 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/kvm_bin_form_stats.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 32b87cc77c8e..0c8241bd9a17 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -38,3 +38,4 @@
 /memslot_modification_stress_test
 /set_memory_region_test
 /steal_time
+/kvm_bin_form_stats
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index a6d61f451f88..5cdd52ccedf2 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -72,6 +72,7 @@ TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_x86_64 += memslot_modification_stress_test
 TEST_GEN_PROGS_x86_64 += set_memory_region_test
 TEST_GEN_PROGS_x86_64 += steal_time
+TEST_GEN_PROGS_x86_64 += kvm_bin_form_stats
 
 TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
 TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list-sve
@@ -81,6 +82,7 @@ TEST_GEN_PROGS_aarch64 += dirty_log_perf_test
 TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_aarch64 += set_memory_region_test
 TEST_GEN_PROGS_aarch64 += steal_time
+TEST_GEN_PROGS_aarch64 += kvm_bin_form_stats
 
 TEST_GEN_PROGS_s390x = s390x/memop
 TEST_GEN_PROGS_s390x += s390x/resets
@@ -89,6 +91,7 @@ TEST_GEN_PROGS_s390x += demand_paging_test
 TEST_GEN_PROGS_s390x += dirty_log_test
 TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
 TEST_GEN_PROGS_s390x += set_memory_region_test
+TEST_GEN_PROGS_s390x += kvm_bin_form_stats
 
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
 LIBKVM += $(LIBKVM_$(UNAME_M))
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 2d7eb6989e83..407f3a35ed3b 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -378,4 +378,7 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
 #define GUEST_ASSERT_4(_condition, arg1, arg2, arg3, arg4) \
 	__GUEST_ASSERT((_condition), 4, (arg1), (arg2), (arg3), (arg4))
 
+int vm_get_statsfd(struct kvm_vm *vm);
+int vcpu_get_statsfd(struct kvm_vm *vm, uint32_t vcpuid);
+
 #endif /* SELFTEST_KVM_UTIL_H */
diff --git a/tools/testing/selftests/kvm/kvm_bin_form_stats.c b/tools/testing/selftests/kvm/kvm_bin_form_stats.c
new file mode 100644
index 000000000000..5ed2fe74ce55
--- /dev/null
+++ b/tools/testing/selftests/kvm/kvm_bin_form_stats.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * kvm_bin_form_stats
+ *
+ * Copyright (C) 2021, Google LLC.
+ *
+ * Test the fd-based interface for KVM statistics.
+ */
+
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+
+#include "test_util.h"
+
+#include "kvm_util.h"
+#include "asm/kvm.h"
+#include "linux/kvm.h"
+
+int vm_stats_test(struct kvm_vm *vm)
+{
+	ssize_t ret;
+	int i, stats_fd, err = -1;
+	size_t size_desc, size_data = 0;
+	struct kvm_stats_header header;
+	struct kvm_stats_desc *stats_desc, *pdesc;
+	struct kvm_vm_stats_data *stats_data;
+
+	// Get fd for VM stats
+	stats_fd = vm_get_statsfd(vm);
+	if (stats_fd < 0) {
+		perror("Get VM stats fd");
+		return err;
+	}
+	// Read kvm vm stats header
+	ret = read(stats_fd, &header, sizeof(header));
+	if (ret != sizeof(header)) {
+		perror("Read VM stats header");
+		goto out_close_fd;
+	}
+	size_desc = sizeof(*stats_desc) + header.name_size;
+	// Check id string in header, that should start with "kvm"
+	if (strncmp(header.id, "kvm", 3) ||
+			strlen(header.id) >= KVM_STATS_ID_MAXLEN) {
+		printf("Invalid KVM VM stats type!\n");
+		goto out_close_fd;
+	}
+	// Sanity check for other fields in header
+	if (header.count == 0) {
+		err = 0;
+		goto out_close_fd;
+	}
+	// Check overlap
+	if (header.desc_offset == 0 || header.data_offset == 0 ||
+			header.desc_offset < sizeof(header) ||
+			header.data_offset < sizeof(header)) {
+		printf("Invalid offset fields in header!\n");
+		goto out_close_fd;
+	}
+	if (header.desc_offset < header.data_offset &&
+			(header.desc_offset + size_desc * header.count >
+			header.data_offset)) {
+		printf("Descriptor block is overlapped with data block!\n");
+		goto out_close_fd;
+	}
+
+	// Allocate memory for stats descriptors
+	stats_desc = calloc(header.count, size_desc);
+	if (!stats_desc) {
+		perror("Allocate memory for VM stats descriptors");
+		goto out_close_fd;
+	}
+	// Read kvm vm stats descriptors
+	ret = pread(stats_fd, stats_desc,
+			size_desc * header.count, header.desc_offset);
+	if (ret != size_desc * header.count) {
+		perror("Read KVM VM stats descriptors");
+		goto out_free_desc;
+	}
+	// Sanity check for fields in descriptors
+	for (i = 0; i < header.count; ++i) {
+		pdesc = (void *)stats_desc + i * size_desc;
+		// Check type,unit,scale boundaries
+		if ((pdesc->flags & KVM_STATS_TYPE_MASK) > KVM_STATS_TYPE_MAX) {
+			printf("Unknown KVM stats type!\n");
+			goto out_free_desc;
+		}
+		if ((pdesc->flags & KVM_STATS_UNIT_MASK) > KVM_STATS_UNIT_MAX) {
+			printf("Unknown KVM stats unit!\n");
+			goto out_free_desc;
+		}
+		if ((pdesc->flags & KVM_STATS_SCALE_MASK) >
+				KVM_STATS_SCALE_MAX) {
+			printf("Unknown KVM stats scale!\n");
+			goto out_free_desc;
+		}
+		/* Check exponent for stats unit
+		 * Exponent for counter should be greater than or equal to 0
+		 * Exponent for unit bytes should be greater than or equal to 0
+		 * Exponent for unit seconds should be less than or equal to 0
+		 * Exponent for unit clock cycles should be greater than or
+		 * equal to 0
+		 */
+		switch (pdesc->flags & KVM_STATS_UNIT_MASK) {
+		case KVM_STATS_UNIT_NONE:
+		case KVM_STATS_UNIT_BYTES:
+		case KVM_STATS_UNIT_CYCLES:
+			if (pdesc->exponent < 0) {
+				printf("Unsupported KVM stats unit!\n");
+				goto out_free_desc;
+			}
+			break;
+		case KVM_STATS_UNIT_SECONDS:
+			if (pdesc->exponent > 0) {
+				printf("Unsupported KVM stats unit!\n");
+				goto out_free_desc;
+			}
+			break;
+		}
+		// Check name string
+		if (strlen(pdesc->name) >= header.name_size) {
+			printf("KVM stats name(%s) too long!\n", pdesc->name);
+			goto out_free_desc;
+		}
+		// Check size field, which should not be zero
+		if (pdesc->size == 0) {
+			printf("KVM descriptor(%s) with size of 0!\n",
+					pdesc->name);
+			goto out_free_desc;
+		}
+		size_data = pdesc->size * sizeof(stats_data->value[0]);
+	}
+	// Check overlap
+	if (header.data_offset < header.desc_offset &&
+		header.data_offset + size_data > header.desc_offset) {
+		printf("Data block is overlapped with Descriptor block!\n");
+		goto out_free_desc;
+	}
+
+	// Allocate memory for stats data
+	stats_data = malloc(size_data);
+	if (!stats_data) {
+		perror("Allocate memory for VM stats data");
+		goto out_free_desc;
+	}
+	// Read kvm vm stats data
+	ret = pread(stats_fd, stats_data, size_data, header.data_offset);
+	if (ret != size_data) {
+		perror("Read KVM VM stats data");
+		goto out_free_data;
+	}
+
+	err = 0;
+out_free_data:
+	free(stats_data);
+out_free_desc:
+	free(stats_desc);
+out_close_fd:
+	close(stats_fd);
+	return err;
+}
+
+int vcpu_stats_test(struct kvm_vm *vm, int vcpu_id)
+{
+	ssize_t ret;
+	int i, stats_fd, err = -1;
+	size_t size_desc, size_data = 0;
+	struct kvm_stats_header header;
+	struct kvm_stats_desc *stats_desc, *pdesc;
+	struct kvm_vcpu_stats_data *stats_data;
+
+	// Get fd for VCPU stats
+	stats_fd = vcpu_get_statsfd(vm, vcpu_id);
+	if (stats_fd < 0) {
+		perror("Get VCPU stats fd");
+		return err;
+	}
+	// Read kvm vcpu stats header
+	ret = read(stats_fd, &header, sizeof(header));
+	if (ret != sizeof(header)) {
+		perror("Read VCPU stats header");
+		goto out_close_fd;
+	}
+	size_desc = sizeof(*stats_desc) + header.name_size;
+	// Check id string in header, that should start with "kvm"
+	if (strncmp(header.id, "kvm", 3) ||
+			strlen(header.id) >= KVM_STATS_ID_MAXLEN) {
+		printf("Invalid KVM VCPU stats type!\n");
+		goto out_close_fd;
+	}
+	// Sanity check for other fields in header
+	if (header.count == 0) {
+		err = 0;
+		goto out_close_fd;
+	}
+	// Check overlap
+	if (header.desc_offset == 0 || header.data_offset == 0 ||
+			header.desc_offset < sizeof(header) ||
+			header.data_offset < sizeof(header)) {
+		printf("Invalid offset fields in header!\n");
+		goto out_close_fd;
+	}
+	if (header.desc_offset < header.data_offset &&
+			(header.desc_offset + size_desc * header.count >
+			header.data_offset)) {
+		printf("Descriptor block is overlapped with data block!\n");
+		goto out_close_fd;
+	}
+
+	// Allocate memory for stats descriptors
+	stats_desc = calloc(header.count, size_desc);
+	if (!stats_desc) {
+		perror("Allocate memory for VCPU stats descriptors");
+		goto out_close_fd;
+	}
+	// Read kvm vcpu stats descriptors
+	ret = pread(stats_fd, stats_desc,
+			size_desc * header.count, header.desc_offset);
+	if (ret != size_desc * header.count) {
+		perror("Read KVM VCPU stats descriptors");
+		goto out_free_desc;
+	}
+	// Sanity check for fields in descriptors
+	for (i = 0; i < header.count; ++i) {
+		pdesc = (void *)stats_desc + i * size_desc;
+		// Check boundaries
+		if ((pdesc->flags & KVM_STATS_TYPE_MASK) > KVM_STATS_TYPE_MAX) {
+			printf("Unknown KVM stats type!\n");
+			goto out_free_desc;
+		}
+		if ((pdesc->flags & KVM_STATS_UNIT_MASK) > KVM_STATS_UNIT_MAX) {
+			printf("Unknown KVM stats unit!\n");
+			goto out_free_desc;
+		}
+		if ((pdesc->flags & KVM_STATS_SCALE_MASK) >
+				KVM_STATS_SCALE_MAX) {
+			printf("Unknown KVM stats scale!\n");
+			goto out_free_desc;
+		}
+		/* Check exponent for stats unit
+		 * Exponent for counter should be greater than or equal to 0
+		 * Exponent for unit bytes should be greater than or equal to 0
+		 * Exponent for unit seconds should be less than or equal to 0
+		 * Exponent for unit clock cycles should be greater than or
+		 * equal to 0
+		 */
+		switch (pdesc->flags & KVM_STATS_UNIT_MASK) {
+		case KVM_STATS_UNIT_NONE:
+		case KVM_STATS_UNIT_BYTES:
+		case KVM_STATS_UNIT_CYCLES:
+			if (pdesc->exponent < 0) {
+				printf("Unsupported KVM stats unit!\n");
+				goto out_free_desc;
+			}
+			break;
+		case KVM_STATS_UNIT_SECONDS:
+			if (pdesc->exponent > 0) {
+				printf("Unsupported KVM stats unit!\n");
+				goto out_free_desc;
+			}
+			break;
+		}
+		// Check name string
+		if (strlen(pdesc->name) >= header.name_size) {
+			printf("KVM stats name(%s) too long!\n", pdesc->name);
+			goto out_free_desc;
+		}
+		// Check size field, which should not be zero
+		if (pdesc->size == 0) {
+			printf("KVM descriptor(%s) with size of 0!\n",
+					pdesc->name);
+			goto out_free_desc;
+		}
+		size_data = pdesc->size * sizeof(stats_data->value[0]);
+	}
+	// Check overlap
+	if (header.data_offset < header.desc_offset &&
+		header.data_offset + size_data > header.desc_offset) {
+		printf("Data block is overlapped with Descriptor block!\n");
+		goto out_free_desc;
+	}
+
+	// Allocate memory for stats data
+	stats_data = malloc(size_data);
+	if (!stats_data) {
+		perror("Allocate memory for VCPU stats data");
+		goto out_free_desc;
+	}
+	// Read kvm vcpu stats data
+	ret = pread(stats_fd, stats_data, size_data, header.data_offset);
+	if (ret != size_data) {
+		perror("Read KVM VCPU stats data");
+		goto out_free_data;
+	}
+
+	err = 0;
+out_free_data:
+	free(stats_data);
+out_free_desc:
+	free(stats_desc);
+out_close_fd:
+	close(stats_fd);
+	return err;
+}
+
+/*
+ * Usage: kvm_bin_form_stats [#vm] [#vcpu]
+ * The first parameter #vm set the number of VMs being created.
+ * The second parameter #vcpu set the number of VCPUs being created.
+ * By default, 1 VM and 1 VCPU for the VM would be created for testing.
+ */
+
+int main(int argc, char *argv[])
+{
+	int max_vm = 1, max_vcpu = 1, ret, i, j, err = -1;
+	struct kvm_vm **vms;
+
+	// Get the number of VMs and VCPUs that would be created for testing.
+	if (argc > 1) {
+		max_vm = strtol(argv[1], NULL, 0);
+		if (max_vm <= 0)
+			max_vm = 1;
+	}
+	if (argc > 2 ) {
+		max_vcpu = strtol(argv[2], NULL, 0);
+		if (max_vcpu <= 0)
+			max_vcpu = 1;
+	}
+
+	// Check the extension for binary stats
+	ret = kvm_check_cap(KVM_CAP_STATS_BINARY_FD);
+	if (ret < 0) {
+		printf("Binary form statistics interface is not supported!\n");
+		return err;
+	}
+
+	// Create VMs and VCPUs
+	vms = malloc(sizeof(vms[0]) * max_vm);
+	if (!vms) {
+		perror("Allocate memory for storing VM pointers");
+		return err;
+	}
+	for (i = 0; i < max_vm; ++i) {
+		vms[i] = vm_create(VM_MODE_DEFAULT,
+				DEFAULT_GUEST_PHY_PAGES, O_RDWR);
+		for (j = 0; j < max_vcpu; ++j) {
+			vm_vcpu_add(vms[i], j);
+		}
+	}
+
+	// Check stats read for every VM and VCPU
+	for (i = 0; i < max_vm; ++i) {
+		if (vm_stats_test(vms[i]))
+			goto out_free_vm;
+		for (j = 0; j < max_vcpu; ++j) {
+			if (vcpu_stats_test(vms[i], j))
+				goto out_free_vm;
+		}
+	}
+
+	err = 0;
+out_free_vm:
+	for (i = 0; i < max_vm; ++i)
+		kvm_vm_free(vms[i]);
+	free(vms);
+	return err;
+}
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e5fbf16f725b..be305e7b54ca 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2013,3 +2013,14 @@ unsigned int vm_calc_num_guest_pages(enum vm_guest_mode mode, size_t size)
 	n = DIV_ROUND_UP(size, vm_guest_mode_params[mode].page_size);
 	return vm_adjust_num_guest_pages(mode, n);
 }
+
+int vm_get_statsfd(struct kvm_vm *vm)
+{
+	return ioctl(vm->fd, KVM_STATS_GETFD, NULL);
+}
+
+int vcpu_get_statsfd(struct kvm_vm *vm, uint32_t vcpuid)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	return ioctl(vcpu->fd, KVM_STATS_GETFD, NULL);
+}
-- 
2.31.1.295.g9ea45b61b8-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
