Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 286DC35391A
	for <lists+kvmarm@lfdr.de>; Sun,  4 Apr 2021 19:23:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CB7134BC12;
	Sun,  4 Apr 2021 13:23:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hcmqRBfS+Sik; Sun,  4 Apr 2021 13:23:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A01D64BBC9;
	Sun,  4 Apr 2021 13:23:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CC5154BBC9
 for <kvmarm@lists.cs.columbia.edu>; Sun,  4 Apr 2021 13:23:17 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bXaAo7aTkePh for <kvmarm@lists.cs.columbia.edu>;
 Sun,  4 Apr 2021 13:23:16 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DBD974BB95
 for <kvmarm@lists.cs.columbia.edu>; Sun,  4 Apr 2021 13:23:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617556996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fobR56P1Wx6MurFew5By3DwSeDXha3rhr+G2cvBGNCw=;
 b=TM3ZUSnV+VCUoE8iv90IMoydfu834bQuzAH0n9h38dACj9TVVDuyiBEdna9dTHIl31Dotq
 Z2cA1YFU7Wmh5xZJOgncabtFPejRtPAbC1HED7zA38ATig9AL0JvonRUOBDbLfoa+qLZ/b
 sOrTXeNNkLkho5j1R+FBFYuofcvEcFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-Mz_V6AYkP-SWUokEaJYtuQ-1; Sun, 04 Apr 2021 13:23:15 -0400
X-MC-Unique: Mz_V6AYkP-SWUokEaJYtuQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF22284B9A1;
 Sun,  4 Apr 2021 17:23:13 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-13.ams2.redhat.com [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9030F10027C4;
 Sun,  4 Apr 2021 17:23:10 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, maz@kernel.org, drjones@redhat.com,
 alexandru.elisei@arm.com
Subject: [PATCH v5 6/8] kvm: arm64: vgic-v3: Introduce
 vgic_v3_free_redist_region()
Date: Sun,  4 Apr 2021 19:22:41 +0200
Message-Id: <20210404172243.504309-7-eric.auger@redhat.com>
In-Reply-To: <20210404172243.504309-1-eric.auger@redhat.com>
References: <20210404172243.504309-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: shuah@kernel.org, pbonzini@redhat.com
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

To improve the readability, we introduce the new
vgic_v3_free_redist_region helper and also rename
vgic_v3_insert_redist_region into vgic_v3_alloc_redist_region

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 arch/arm64/kvm/vgic/vgic-init.c    |  6 ++----
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 17 +++++++++++------
 arch/arm64/kvm/vgic/vgic.h         |  1 +
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index cf6faa0aeddb..58cbda00e56d 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -338,10 +338,8 @@ static void kvm_vgic_dist_destroy(struct kvm *kvm)
 	dist->vgic_dist_base = VGIC_ADDR_UNDEF;
 
 	if (dist->vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3) {
-		list_for_each_entry_safe(rdreg, next, &dist->rd_regions, list) {
-			list_del(&rdreg->list);
-			kfree(rdreg);
-		}
+		list_for_each_entry_safe(rdreg, next, &dist->rd_regions, list)
+			vgic_v3_free_redist_region(rdreg);
 		INIT_LIST_HEAD(&dist->rd_regions);
 	} else {
 		dist->vgic_cpu_base = VGIC_ADDR_UNDEF;
diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index fec0555529c0..e1ed0c5a8eaa 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -768,7 +768,7 @@ static int vgic_register_all_redist_iodevs(struct kvm *kvm)
 }
 
 /**
- * vgic_v3_insert_redist_region - Insert a new redistributor region
+ * vgic_v3_alloc_redist_region - Allocate a new redistributor region
  *
  * Performs various checks before inserting the rdist region in the list.
  * Those tests depend on whether the size of the rdist region is known
@@ -782,8 +782,8 @@ static int vgic_register_all_redist_iodevs(struct kvm *kvm)
  *
  * Return 0 on success, < 0 otherwise
  */
-static int vgic_v3_insert_redist_region(struct kvm *kvm, uint32_t index,
-					gpa_t base, uint32_t count)
+static int vgic_v3_alloc_redist_region(struct kvm *kvm, uint32_t index,
+				       gpa_t base, uint32_t count)
 {
 	struct vgic_dist *d = &kvm->arch.vgic;
 	struct vgic_redist_region *rdreg;
@@ -848,11 +848,17 @@ static int vgic_v3_insert_redist_region(struct kvm *kvm, uint32_t index,
 	return ret;
 }
 
+void vgic_v3_free_redist_region(struct vgic_redist_region *rdreg)
+{
+	list_del(&rdreg->list);
+	kfree(rdreg);
+}
+
 int vgic_v3_set_redist_base(struct kvm *kvm, u32 index, u64 addr, u32 count)
 {
 	int ret;
 
-	ret = vgic_v3_insert_redist_region(kvm, index, addr, count);
+	ret = vgic_v3_alloc_redist_region(kvm, index, addr, count);
 	if (ret)
 		return ret;
 
@@ -865,8 +871,7 @@ int vgic_v3_set_redist_base(struct kvm *kvm, u32 index, u64 addr, u32 count)
 		struct vgic_redist_region *rdreg;
 
 		rdreg = vgic_v3_rdist_region_from_index(kvm, index);
-		list_del(&rdreg->list);
-		kfree(rdreg);
+		vgic_v3_free_redist_region(rdreg);
 		return ret;
 	}
 
diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
index 64fcd7511110..bc418c2c1214 100644
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
@@ -293,6 +293,7 @@ vgic_v3_rd_region_size(struct kvm *kvm, struct vgic_redist_region *rdreg)
 
 struct vgic_redist_region *vgic_v3_rdist_region_from_index(struct kvm *kvm,
 							   u32 index);
+void vgic_v3_free_redist_region(struct vgic_redist_region *rdreg);
 
 bool vgic_v3_rdist_overlap(struct kvm *kvm, gpa_t base, size_t size);
 
-- 
2.26.3

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
