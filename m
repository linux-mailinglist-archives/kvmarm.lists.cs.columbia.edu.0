Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id ACD58339500
	for <lists+kvmarm@lfdr.de>; Fri, 12 Mar 2021 18:33:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 55ADB4B324;
	Fri, 12 Mar 2021 12:33:04 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i2tVg40Gf9sx; Fri, 12 Mar 2021 12:33:04 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 941DA4B592;
	Fri, 12 Mar 2021 12:33:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 177C54B53D
 for <kvmarm@lists.cs.columbia.edu>; Fri, 12 Mar 2021 12:33:02 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8tjS5qcXu85K for <kvmarm@lists.cs.columbia.edu>;
 Fri, 12 Mar 2021 12:33:00 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A833D4B53C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 12 Mar 2021 12:33:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615570380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EnVR6qOVBRd8kOthgXzIWyIygHlg5l5jPzBh8/NMyWc=;
 b=hZFoeWs0byQYeSkFj6ngirQoGzycGWqOWN4aOwZkIboiRhrOQvrEVwk+yvdVEDNLLLhuPr
 3FIyG+EvsV0I3D3exq9+Gkcju9VzE9hWnmq2ckcwLZAvZTY2m9Kbr6EsezN9BejdbVSX8F
 xu3/XKt+TaAanyjErb7jgv5q49fp1XM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-lI4USvLyPTajr92wadrJhQ-1; Fri, 12 Mar 2021 12:32:58 -0500
X-MC-Unique: lI4USvLyPTajr92wadrJhQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EC0C8030A0;
 Fri, 12 Mar 2021 17:32:56 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-254.ams2.redhat.com [10.36.112.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1F951009962;
 Fri, 12 Mar 2021 17:32:48 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, maz@kernel.org, drjones@redhat.com,
 alexandru.elisei@arm.com
Subject: [PATCH v3 7/8] KVM: arm64: vgic-v3: Expose GICR_TYPER.Last for
 userspace
Date: Fri, 12 Mar 2021 18:32:01 +0100
Message-Id: <20210312173202.89576-8-eric.auger@redhat.com>
In-Reply-To: <20210312173202.89576-1-eric.auger@redhat.com>
References: <20210312173202.89576-1-eric.auger@redhat.com>
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

Commit 23bde34771f1 ("KVM: arm64: vgic-v3: Drop the
reporting of GICR_TYPER.Last for userspace") temporarily fixed
a bug identified when attempting to access the GICR_TYPER
register before the redistributor region setting, but dropped
the support of the LAST bit.

Emulating the GICR_TYPER.Last bit still makes sense for
architecture compliance though. This patch restores its support
(if the redistributor region was set) while keeping the code safe.

We introduce a new helper, vgic_mmio_vcpu_rdist_is_last() which
computes whether a redistributor is the highest one of a series
of redistributor contributor pages.

The spec says "Indicates whether this Redistributor is the
highest-numbered Redistributor in a series of contiguous
Redistributor pages."

The code is a bit convulated since there is no guarantee
redistributors are added in a given reditributor region in
ascending order. In that case the current implementation was
wrong. Also redistributor regions can be contiguous
and registered in non increasing base address order.

So the index of redistributors are stored in an array within
the redistributor region structure.

With this new implementation we do not need to have a uaccess
read accessor anymore.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 arch/arm64/kvm/vgic/vgic-init.c    |  7 +--
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 97 ++++++++++++++++++++----------
 arch/arm64/kvm/vgic/vgic.h         |  1 +
 include/kvm/arm_vgic.h             |  3 +
 4 files changed, 73 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index cf6faa0aeddb..61150c34c268 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -190,6 +190,7 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 	int i;
 
 	vgic_cpu->rd_iodev.base_addr = VGIC_ADDR_UNDEF;
+	vgic_cpu->index = vcpu->vcpu_id;
 
 	INIT_LIST_HEAD(&vgic_cpu->ap_list_head);
 	raw_spin_lock_init(&vgic_cpu->ap_list_lock);
@@ -338,10 +339,8 @@ static void kvm_vgic_dist_destroy(struct kvm *kvm)
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
index 987e366c8000..652998ed0b55 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -251,45 +251,57 @@ static void vgic_mmio_write_v3r_ctlr(struct kvm_vcpu *vcpu,
 		vgic_enable_lpis(vcpu);
 }
 
+static bool vgic_mmio_vcpu_rdist_is_last(struct kvm_vcpu *vcpu)
+{
+	struct vgic_dist *vgic = &vcpu->kvm->arch.vgic;
+	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
+	struct vgic_redist_region *rdreg = vgic_cpu->rdreg;
+
+	if (!rdreg)
+		return false;
+
+	if (!rdreg->count && vgic_cpu->rdreg_index == (rdreg->count - 1)) {
+		/* check whether there is no other contiguous rdist region */
+		struct list_head *rd_regions = &vgic->rd_regions;
+		struct vgic_redist_region *iter;
+
+		list_for_each_entry(iter, rd_regions, list) {
+			if (iter->base == rdreg->base + rdreg->count * KVM_VGIC_V3_REDIST_SIZE &&
+				iter->free_index > 0) {
+			/* check the first rdist index of this region, if any */
+				if (vgic_cpu->index < iter->rdist_indices[0])
+					return false;
+			}
+		}
+	} else if (vgic_cpu->rdreg_index < rdreg->free_index - 1) {
+		/* look at the index of next rdist */
+		int next_rdist_index = rdreg->rdist_indices[vgic_cpu->rdreg_index + 1];
+
+		if (vgic_cpu->index < next_rdist_index)
+			return false;
+	}
+	return true;
+}
+
 static unsigned long vgic_mmio_read_v3r_typer(struct kvm_vcpu *vcpu,
 					      gpa_t addr, unsigned int len)
 {
 	unsigned long mpidr = kvm_vcpu_get_mpidr_aff(vcpu);
-	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
-	struct vgic_redist_region *rdreg = vgic_cpu->rdreg;
 	int target_vcpu_id = vcpu->vcpu_id;
-	gpa_t last_rdist_typer = rdreg->base + GICR_TYPER +
-			(rdreg->free_index - 1) * KVM_VGIC_V3_REDIST_SIZE;
 	u64 value;
 
 	value = (u64)(mpidr & GENMASK(23, 0)) << 32;
 	value |= ((target_vcpu_id & 0xffff) << 8);
 
-	if (addr == last_rdist_typer)
+	if (vgic_has_its(vcpu->kvm))
+		value |= GICR_TYPER_PLPIS;
+
+	if (vgic_mmio_vcpu_rdist_is_last(vcpu))
 		value |= GICR_TYPER_LAST;
-	if (vgic_has_its(vcpu->kvm))
-		value |= GICR_TYPER_PLPIS;
 
 	return extract_bytes(value, addr & 7, len);
 }
 
-static unsigned long vgic_uaccess_read_v3r_typer(struct kvm_vcpu *vcpu,
-						 gpa_t addr, unsigned int len)
-{
-	unsigned long mpidr = kvm_vcpu_get_mpidr_aff(vcpu);
-	int target_vcpu_id = vcpu->vcpu_id;
-	u64 value;
-
-	value = (u64)(mpidr & GENMASK(23, 0)) << 32;
-	value |= ((target_vcpu_id & 0xffff) << 8);
-
-	if (vgic_has_its(vcpu->kvm))
-		value |= GICR_TYPER_PLPIS;
-
-	/* reporting of the Last bit is not supported for userspace */
-	return extract_bytes(value, addr & 7, len);
-}
-
 static unsigned long vgic_mmio_read_v3r_iidr(struct kvm_vcpu *vcpu,
 					     gpa_t addr, unsigned int len)
 {
@@ -612,7 +624,7 @@ static const struct vgic_register_region vgic_v3_rd_registers[] = {
 		VGIC_ACCESS_32bit),
 	REGISTER_DESC_WITH_LENGTH_UACCESS(GICR_TYPER,
 		vgic_mmio_read_v3r_typer, vgic_mmio_write_wi,
-		vgic_uaccess_read_v3r_typer, vgic_mmio_uaccess_write_wi, 8,
+		NULL, vgic_mmio_uaccess_write_wi, 8,
 		VGIC_ACCESS_64bit | VGIC_ACCESS_32bit),
 	REGISTER_DESC_WITH_LENGTH(GICR_WAKER,
 		vgic_mmio_read_raz, vgic_mmio_write_wi, 4,
@@ -714,6 +726,16 @@ int vgic_register_redist_iodev(struct kvm_vcpu *vcpu)
 		return -EINVAL;
 
 	vgic_cpu->rdreg = rdreg;
+	vgic_cpu->rdreg_index = rdreg->free_index;
+	if (!rdreg->count) {
+		void *p = krealloc(rdreg->rdist_indices,
+				   (vgic_cpu->rdreg_index + 1) * sizeof(u32),
+				   GFP_KERNEL);
+		if (!p)
+			return -ENOMEM;
+		rdreg->rdist_indices = p;
+	}
+	rdreg->rdist_indices[vgic_cpu->rdreg_index] = vgic_cpu->index;
 
 	rd_base = rdreg->base + rdreg->free_index * KVM_VGIC_V3_REDIST_SIZE;
 
@@ -768,7 +790,7 @@ static int vgic_register_all_redist_iodevs(struct kvm *kvm)
 }
 
 /**
- * vgic_v3_insert_redist_region - Insert a new redistributor region
+ * vgic_v3_alloc_redist_region - Allocate a new redistributor region
  *
  * Performs various checks before inserting the rdist region in the list.
  * Those tests depend on whether the size of the rdist region is known
@@ -782,8 +804,8 @@ static int vgic_register_all_redist_iodevs(struct kvm *kvm)
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
@@ -839,6 +861,13 @@ static int vgic_v3_insert_redist_region(struct kvm *kvm, uint32_t index,
 	rdreg->count = count;
 	rdreg->free_index = 0;
 	rdreg->index = index;
+	if (count) {
+		rdreg->rdist_indices = kcalloc(count, sizeof(u32), GFP_KERNEL);
+		if (!rdreg->rdist_indices) {
+			ret = -ENOMEM;
+			goto free;
+		}
+	}
 
 	list_add_tail(&rdreg->list, rd_regions);
 	return 0;
@@ -847,11 +876,18 @@ static int vgic_v3_insert_redist_region(struct kvm *kvm, uint32_t index,
 	return ret;
 }
 
+void vgic_v3_free_redist_region(struct vgic_redist_region *rdreg)
+{
+	list_del(&rdreg->list);
+	kfree(rdreg->rdist_indices);
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
 
@@ -864,8 +900,7 @@ int vgic_v3_set_redist_base(struct kvm *kvm, u32 index, u64 addr, u32 count)
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
 
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 3d74f1060bd1..9a3f060ac354 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -197,6 +197,7 @@ struct vgic_redist_region {
 	gpa_t base;
 	u32 count; /* number of redistributors or 0 if single region */
 	u32 free_index; /* index of the next free redistributor */
+	int *rdist_indices; /* indices of the redistributors */
 	struct list_head list;
 };
 
@@ -322,6 +323,8 @@ struct vgic_cpu {
 	 */
 	struct vgic_io_device	rd_iodev;
 	struct vgic_redist_region *rdreg;
+	u32 rdreg_index;
+	int index; /* vcpu index */
 
 	/* Contains the attributes and gpa of the LPI pending tables. */
 	u64 pendbaser;
-- 
2.26.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
