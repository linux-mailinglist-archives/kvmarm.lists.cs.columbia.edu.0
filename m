Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 95F4F462178
	for <lists+kvmarm@lfdr.de>; Mon, 29 Nov 2021 21:06:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 47D644B104;
	Mon, 29 Nov 2021 15:06:14 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gl0+BF+GwgJK; Mon, 29 Nov 2021 15:06:12 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 681694B13D;
	Mon, 29 Nov 2021 15:06:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9C8B449E57
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Nov 2021 15:06:10 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZKfXWMETxQrf for <kvmarm@lists.cs.columbia.edu>;
 Mon, 29 Nov 2021 15:06:08 -0500 (EST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4E9694B105
 for <kvmarm@lists.cs.columbia.edu>; Mon, 29 Nov 2021 15:06:08 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id D84E3CE13D8;
 Mon, 29 Nov 2021 20:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4CEC53FAD;
 Mon, 29 Nov 2021 20:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638216364;
 bh=w8pDdRJcrwVDDb0ewTMpJ1QlCAiVNFEIVQTNnE1IWTc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EqiG/jKUsdCS5u1CWRDR45FMRsdpYaKxSC3SuLbEhARISuUXRIHK441T/lUVkEDch
 7a5pg6R+ZXPzQ3eQ/AL/OmM8YeRk+OkC2n8HAsljIco9DcBzC+v+kEIKAiLxDcBLhR
 ApD0psLeteODfYwvD+W4EI+Vr8en2MJ1TVk8lhtcjw22P3dr3N/JOU/w4igPeUXKNB
 FK8TcWSp8WQWzARlzwXVZawUA9yXqZoOeJVJjmdyl4qdyqgfjSPrYdyhQaw2hJm91Y
 jtH1jRdDHrf906kU02/ax83HJsxW73SMxfL7nUhLomDk6At6970EiYNCaLsc2ml4HV
 DX77+bloMiZ9Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <maz@kernel.org>)
 id 1mrmqz-008gvR-T5; Mon, 29 Nov 2021 20:02:22 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Subject: [PATCH v5 39/69] KVM: arm64: nv: Implement nested Stage-2 page table
 walk logic
Date: Mon, 29 Nov 2021 20:01:20 +0000
Message-Id: <20211129200150.351436-40-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129200150.351436-1-maz@kernel.org>
References: <20211129200150.351436-1-maz@kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, andre.przywara@arm.com,
 christoffer.dall@arm.com, jintack@cs.columbia.edu, haibo.xu@linaro.org,
 gankulkarni@os.amperecomputing.com, james.morse@arm.com,
 suzuki.poulose@arm.com, alexandru.elisei@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kernel-team@android.com, Andre Przywara <andre.przywara@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
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

From: Christoffer Dall <christoffer.dall@linaro.org>

Based on the pseudo-code in the ARM ARM, implement a stage 2 software
page table walker.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Jintack Lim <jintack.lim@linaro.org>
[maz: heavily reworked for future ARMv8.4-TTL support]
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/esr.h        |   1 +
 arch/arm64/include/asm/kvm_arm.h    |   2 +
 arch/arm64/include/asm/kvm_nested.h |  13 ++
 arch/arm64/kvm/nested.c             | 267 ++++++++++++++++++++++++++++
 4 files changed, 283 insertions(+)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 6835e4231119..206bfb701791 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -130,6 +130,7 @@
 #define ESR_ELx_CM 		(UL(1) << ESR_ELx_CM_SHIFT)
 
 /* ISS field definitions for exceptions taken in to Hyp */
+#define ESR_ELx_FSC_ADDRSZ	(0x00)
 #define ESR_ELx_CV		(UL(1) << 24)
 #define ESR_ELx_COND_SHIFT	(20)
 #define ESR_ELx_COND_MASK	(UL(0xF) << ESR_ELx_COND_SHIFT)
diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index b8a0d410035b..12f4bc8a805b 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -272,6 +272,8 @@
 #define VTTBR_VMID_SHIFT  (UL(48))
 #define VTTBR_VMID_MASK(size) (_AT(u64, (1 << size) - 1) << VTTBR_VMID_SHIFT)
 
+#define SCTLR_EE	(UL(1) << 25)
+
 /* Hyp System Trap Register */
 #define HSTR_EL2_T(x)	(1 << x)
 
diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index 473ecd1d60d0..b784d7891851 100644
--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -68,6 +68,19 @@ extern struct kvm_s2_mmu *lookup_s2_mmu(struct kvm *kvm, u64 vttbr, u64 hcr);
 extern void kvm_vcpu_load_hw_mmu(struct kvm_vcpu *vcpu);
 extern void kvm_vcpu_put_hw_mmu(struct kvm_vcpu *vcpu);
 
+struct kvm_s2_trans {
+	phys_addr_t output;
+	unsigned long block_size;
+	bool writable;
+	bool readable;
+	int level;
+	u32 esr;
+	u64 upper_attr;
+};
+
+extern int kvm_walk_nested_s2(struct kvm_vcpu *vcpu, phys_addr_t gipa,
+			      struct kvm_s2_trans *result);
+
 int handle_wfx_nested(struct kvm_vcpu *vcpu, bool is_wfe);
 extern bool __forward_traps(struct kvm_vcpu *vcpu, unsigned int reg,
 			    u64 control_bit);
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index b034a2343374..01c5ee5f3545 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -87,6 +87,273 @@ int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+struct s2_walk_info {
+	int	     (*read_desc)(phys_addr_t pa, u64 *desc, void *data);
+	void	     *data;
+	u64	     baddr;
+	unsigned int max_pa_bits;
+	unsigned int pgshift;
+	unsigned int pgsize;
+	unsigned int ps;
+	unsigned int sl;
+	unsigned int t0sz;
+	bool	     be;
+	bool	     el1_aarch32;
+};
+
+static unsigned int ps_to_output_size(unsigned int ps)
+{
+	switch (ps) {
+	case 0: return 32;
+	case 1: return 36;
+	case 2: return 40;
+	case 3: return 42;
+	case 4: return 44;
+	case 5:
+	default:
+		return 48;
+	}
+}
+
+static u32 compute_fsc(int level, u32 fsc)
+{
+	return fsc | (level & 0x3);
+}
+
+static int check_base_s2_limits(struct s2_walk_info *wi,
+				int level, int input_size, int stride)
+{
+	int start_size;
+
+	/* Check translation limits */
+	switch (wi->pgsize) {
+	case SZ_64K:
+		if (level == 0 || (level == 1 && wi->max_pa_bits <= 42))
+			return -EFAULT;
+		break;
+	case SZ_16K:
+		if (level == 0 || (level == 1 && wi->max_pa_bits <= 40))
+			return -EFAULT;
+		break;
+	case SZ_4K:
+		if (level < 0 || (level == 0 && wi->max_pa_bits <= 42))
+			return -EFAULT;
+		break;
+	}
+
+	/* Check input size limits */
+	if (input_size > wi->max_pa_bits &&
+	    (!wi->el1_aarch32 || input_size > 40))
+		return -EFAULT;
+
+	/* Check number of entries in starting level table */
+	start_size = input_size - ((3 - level) * stride + wi->pgshift);
+	if (start_size < 1 || start_size > stride + 4)
+		return -EFAULT;
+
+	return 0;
+}
+
+/* Check if output is within boundaries */
+static int check_output_size(struct s2_walk_info *wi, phys_addr_t output)
+{
+	unsigned int output_size = ps_to_output_size(wi->ps);
+
+	if (output_size > wi->max_pa_bits)
+		output_size = wi->max_pa_bits;
+
+	if (output_size != 48 && (output & GENMASK_ULL(47, output_size)))
+		return -1;
+
+	return 0;
+}
+
+/*
+ * This is essentially a C-version of the pseudo code from the ARM ARM
+ * AArch64.TranslationTableWalk  function.  I strongly recommend looking at
+ * that pseudocode in trying to understand this.
+ *
+ * Must be called with the kvm->srcu read lock held
+ */
+static int walk_nested_s2_pgd(phys_addr_t ipa,
+			      struct s2_walk_info *wi, struct kvm_s2_trans *out)
+{
+	int first_block_level, level, stride, input_size, base_lower_bound;
+	phys_addr_t base_addr;
+	unsigned int addr_top, addr_bottom;
+	u64 desc;  /* page table entry */
+	int ret;
+	phys_addr_t paddr;
+
+	switch (wi->pgsize) {
+	case SZ_64K:
+	case SZ_16K:
+		level = 3 - wi->sl;
+		first_block_level = 2;
+		break;
+	case SZ_4K:
+		level = 2 - wi->sl;
+		first_block_level = 1;
+		break;
+	default:
+		/* GCC is braindead */
+		unreachable();
+	}
+
+	stride = wi->pgshift - 3;
+	input_size = 64 - wi->t0sz;
+	if (input_size > 48 || input_size < 25)
+		return -EFAULT;
+
+	ret = check_base_s2_limits(wi, level, input_size, stride);
+	if (WARN_ON(ret))
+		return ret;
+
+	base_lower_bound = 3 + input_size - ((3 - level) * stride +
+			   wi->pgshift);
+	base_addr = wi->baddr & GENMASK_ULL(47, base_lower_bound);
+
+	if (check_output_size(wi, base_addr)) {
+		out->esr = compute_fsc(level, ESR_ELx_FSC_ADDRSZ);
+		return 1;
+	}
+
+	addr_top = input_size - 1;
+
+	while (1) {
+		phys_addr_t index;
+
+		addr_bottom = (3 - level) * stride + wi->pgshift;
+		index = (ipa & GENMASK_ULL(addr_top, addr_bottom))
+			>> (addr_bottom - 3);
+
+		paddr = base_addr | index;
+		ret = wi->read_desc(paddr, &desc, wi->data);
+		if (ret < 0)
+			return ret;
+
+		/*
+		 * Handle reversedescriptors if endianness differs between the
+		 * host and the guest hypervisor.
+		 */
+		if (wi->be)
+			desc = be64_to_cpu(desc);
+		else
+			desc = le64_to_cpu(desc);
+
+		/* Check for valid descriptor at this point */
+		if (!(desc & 1) || ((desc & 3) == 1 && level == 3)) {
+			out->esr = compute_fsc(level, ESR_ELx_FSC_FAULT);
+			out->upper_attr = desc;
+			return 1;
+		}
+
+		/* We're at the final level or block translation level */
+		if ((desc & 3) == 1 || level == 3)
+			break;
+
+		if (check_output_size(wi, desc)) {
+			out->esr = compute_fsc(level, ESR_ELx_FSC_ADDRSZ);
+			out->upper_attr = desc;
+			return 1;
+		}
+
+		base_addr = desc & GENMASK_ULL(47, wi->pgshift);
+
+		level += 1;
+		addr_top = addr_bottom - 1;
+	}
+
+	if (level < first_block_level) {
+		out->esr = compute_fsc(level, ESR_ELx_FSC_FAULT);
+		out->upper_attr = desc;
+		return 1;
+	}
+
+	/*
+	 * We don't use the contiguous bit in the stage-2 ptes, so skip check
+	 * for misprogramming of the contiguous bit.
+	 */
+
+	if (check_output_size(wi, desc)) {
+		out->esr = compute_fsc(level, ESR_ELx_FSC_ADDRSZ);
+		out->upper_attr = desc;
+		return 1;
+	}
+
+	if (!(desc & BIT(10))) {
+		out->esr = compute_fsc(level, ESR_ELx_FSC_ACCESS);
+		out->upper_attr = desc;
+		return 1;
+	}
+
+	/* Calculate and return the result */
+	paddr = (desc & GENMASK_ULL(47, addr_bottom)) |
+		(ipa & GENMASK_ULL(addr_bottom - 1, 0));
+	out->output = paddr;
+	out->block_size = 1UL << ((3 - level) * stride + wi->pgshift);
+	out->readable = desc & (0b01 << 6);
+	out->writable = desc & (0b10 << 6);
+	out->level = level;
+	out->upper_attr = desc & GENMASK_ULL(63, 52);
+	return 0;
+}
+
+static int read_guest_s2_desc(phys_addr_t pa, u64 *desc, void *data)
+{
+	struct kvm_vcpu *vcpu = data;
+
+	return kvm_read_guest(vcpu->kvm, pa, desc, sizeof(*desc));
+}
+
+static void vtcr_to_walk_info(u64 vtcr, struct s2_walk_info *wi)
+{
+	wi->t0sz = vtcr & TCR_EL2_T0SZ_MASK;
+
+	switch (vtcr & VTCR_EL2_TG0_MASK) {
+	case VTCR_EL2_TG0_4K:
+		wi->pgshift = 12;	 break;
+	case VTCR_EL2_TG0_16K:
+		wi->pgshift = 14;	 break;
+	case VTCR_EL2_TG0_64K:
+	default:
+		wi->pgshift = 16;	 break;
+	}
+
+	wi->pgsize = 1UL << wi->pgshift;
+	wi->ps = (vtcr & VTCR_EL2_PS_MASK) >> VTCR_EL2_PS_SHIFT;
+	wi->sl = (vtcr & VTCR_EL2_SL0_MASK) >> VTCR_EL2_SL0_SHIFT;
+	wi->max_pa_bits = VTCR_EL2_IPA(vtcr);
+}
+
+int kvm_walk_nested_s2(struct kvm_vcpu *vcpu, phys_addr_t gipa,
+		       struct kvm_s2_trans *result)
+{
+	u64 vtcr = vcpu_read_sys_reg(vcpu, VTCR_EL2);
+	struct s2_walk_info wi;
+	int ret;
+
+	result->esr = 0;
+
+	if (!nested_virt_in_use(vcpu))
+		return 0;
+
+	wi.read_desc = read_guest_s2_desc;
+	wi.data = vcpu;
+	wi.baddr = vcpu_read_sys_reg(vcpu, VTTBR_EL2);
+
+	vtcr_to_walk_info(vtcr, &wi);
+
+	wi.be = vcpu_read_sys_reg(vcpu, SCTLR_EL2) & SCTLR_EE;
+	wi.el1_aarch32 = vcpu_mode_is_32bit(vcpu);
+
+	ret = walk_nested_s2_pgd(gipa, &wi, result);
+	if (ret)
+		result->esr |= (kvm_vcpu_get_esr(vcpu) & ~ESR_ELx_FSC);
+
+	return ret;
+}
+
 /* Must be called with kvm->lock held */
 struct kvm_s2_mmu *lookup_s2_mmu(struct kvm *kvm, u64 vttbr, u64 hcr)
 {
-- 
2.30.2

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
