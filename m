Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 24BF3535AED
	for <lists+kvmarm@lfdr.de>; Fri, 27 May 2022 10:04:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 92C054B357;
	Fri, 27 May 2022 04:04:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8SwCoTPRpMGB; Fri, 27 May 2022 04:04:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3220A4B359;
	Fri, 27 May 2022 04:04:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 43AAA4B284
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 May 2022 04:04:01 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yc7hMD8Q-cJE for <kvmarm@lists.cs.columbia.edu>;
 Fri, 27 May 2022 04:03:56 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 05B874B29C
 for <kvmarm@lists.cs.columbia.edu>; Fri, 27 May 2022 04:03:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653638635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OoqvQ0dyHR02Jth+XgYVmPsapMfC+8OL3HcKdN8T8MA=;
 b=ep96kAvQdSkvjws8DbVLngPZJ8GmcEZbuR6oz66KjbXfxlHrlwOKZl6/Fzo+H5HaNNMCBL
 S4fFPtA0ktiPnCvu6OWCNlDqG45iBguK8Iv21lZOXFVgXccZMx3KuJ2myFT2sFlgcCxUkY
 /Tqo0v5hszKEkGUbg/QcTjUB5DznEQc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-6qWTa95VMhCdNiYpbaFZFg-1; Fri, 27 May 2022 04:03:52 -0400
X-MC-Unique: 6qWTa95VMhCdNiYpbaFZFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A21661C161AD;
 Fri, 27 May 2022 08:03:51 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-91.pek2.redhat.com [10.72.12.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 622412026D64;
 Fri, 27 May 2022 08:03:42 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v7 01/22] KVM: arm64: Extend smccc_get_argx()
Date: Fri, 27 May 2022 16:02:32 +0800
Message-Id: <20220527080253.1562538-2-gshan@redhat.com>
In-Reply-To: <20220527080253.1562538-1-gshan@redhat.com>
References: <20220527080253.1562538-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Cc: maz@kernel.org, shijie@amperemail.onmicrosoft.com,
 linux-kernel@vger.kernel.org, eauger@redhat.com, shan.gavin@gmail.com,
 Jonathan.Cameron@huawei.com, pbonzini@redhat.com, vkuznets@redhat.com,
 will@kernel.org
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

Currently, there are 3 inline functions to retrieve SMCCC arguments,
but the number of arguments is limited to 3. We need to retrieve
more SMCCC arguments when SDEI virtualization is supported.

This introduces smccc_get_arg(), which accepts @index to indicate
the SMCCC argument to be retrieved. Besides, smccc_get_function()
also calls into this newly introduced helper. Further more, we also
mechanically replace smccc_get_{arg1, arg2, arg3}() using the newly
introduced helper.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/hypercalls.c  |  4 ++--
 arch/arm64/kvm/psci.c        | 14 +++++++-------
 arch/arm64/kvm/pvtime.c      |  2 +-
 arch/arm64/kvm/trng.c        |  4 ++--
 include/kvm/arm_hypercalls.h | 19 +++++--------------
 5 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index c9f401fa01a9..69f437f0d7c7 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -41,7 +41,7 @@ static void kvm_ptp_get_time(struct kvm_vcpu *vcpu, u64 *val)
 	 * (virtual or physical) with the first argument of the SMCCC
 	 * call. In case the identifier is not supported, error out.
 	 */
-	feature = smccc_get_arg1(vcpu);
+	feature = smccc_get_arg(vcpu, 1);
 	switch (feature) {
 	case KVM_PTP_VIRT_COUNTER:
 		cycles = systime_snapshot.cycles - vcpu_read_sys_reg(vcpu, CNTVOFF_EL2);
@@ -137,7 +137,7 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 		val[0] = ARM_SMCCC_VERSION_1_1;
 		break;
 	case ARM_SMCCC_ARCH_FEATURES_FUNC_ID:
-		feature = smccc_get_arg1(vcpu);
+		feature = smccc_get_arg(vcpu, 1);
 		switch (feature) {
 		case ARM_SMCCC_ARCH_WORKAROUND_1:
 			switch (arm64_get_spectre_v2_state()) {
diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
index 7fbc4c1b9df0..5394b8a69e10 100644
--- a/arch/arm64/kvm/psci.c
+++ b/arch/arm64/kvm/psci.c
@@ -64,7 +64,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	struct kvm_vcpu *vcpu = NULL;
 	unsigned long cpu_id;
 
-	cpu_id = smccc_get_arg1(source_vcpu);
+	cpu_id = smccc_get_arg(source_vcpu, 1);
 	if (!kvm_psci_valid_affinity(source_vcpu, cpu_id))
 		return PSCI_RET_INVALID_PARAMS;
 
@@ -85,7 +85,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 
 	reset_state = &vcpu->arch.reset_state;
 
-	reset_state->pc = smccc_get_arg2(source_vcpu);
+	reset_state->pc = smccc_get_arg(source_vcpu, 2);
 
 	/* Propagate caller endianness */
 	reset_state->be = kvm_vcpu_is_be(source_vcpu);
@@ -94,7 +94,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 	 * NOTE: We always update r0 (or x0) because for PSCI v0.1
 	 * the general purpose registers are undefined upon CPU_ON.
 	 */
-	reset_state->r0 = smccc_get_arg3(source_vcpu);
+	reset_state->r0 = smccc_get_arg(source_vcpu, 3);
 
 	WRITE_ONCE(reset_state->reset, true);
 	kvm_make_request(KVM_REQ_VCPU_RESET, vcpu);
@@ -121,8 +121,8 @@ static unsigned long kvm_psci_vcpu_affinity_info(struct kvm_vcpu *vcpu)
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_vcpu *tmp;
 
-	target_affinity = smccc_get_arg1(vcpu);
-	lowest_affinity_level = smccc_get_arg2(vcpu);
+	target_affinity = smccc_get_arg(vcpu, 1);
+	lowest_affinity_level = smccc_get_arg(vcpu, 2);
 
 	if (!kvm_psci_valid_affinity(vcpu, target_affinity))
 		return PSCI_RET_INVALID_PARAMS;
@@ -318,7 +318,7 @@ static int kvm_psci_1_x_call(struct kvm_vcpu *vcpu, u32 minor)
 		val = minor == 0 ? KVM_ARM_PSCI_1_0 : KVM_ARM_PSCI_1_1;
 		break;
 	case PSCI_1_0_FN_PSCI_FEATURES:
-		arg = smccc_get_arg1(vcpu);
+		arg = smccc_get_arg(vcpu, 1);
 		val = kvm_psci_check_allowed_function(vcpu, arg);
 		if (val)
 			break;
@@ -372,7 +372,7 @@ static int kvm_psci_1_x_call(struct kvm_vcpu *vcpu, u32 minor)
 		fallthrough;
 	case PSCI_1_1_FN64_SYSTEM_RESET2:
 		if (minor >= 1) {
-			arg = smccc_get_arg1(vcpu);
+			arg = smccc_get_arg(vcpu, 1);
 
 			if (arg <= PSCI_1_1_RESET_TYPE_SYSTEM_WARM_RESET ||
 			    arg >= PSCI_1_1_RESET_TYPE_VENDOR_START) {
diff --git a/arch/arm64/kvm/pvtime.c b/arch/arm64/kvm/pvtime.c
index 78a09f7a6637..05e775fc9e8b 100644
--- a/arch/arm64/kvm/pvtime.c
+++ b/arch/arm64/kvm/pvtime.c
@@ -34,7 +34,7 @@ void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
 
 long kvm_hypercall_pv_features(struct kvm_vcpu *vcpu)
 {
-	u32 feature = smccc_get_arg1(vcpu);
+	u32 feature = smccc_get_arg(vcpu, 1);
 	long val = SMCCC_RET_NOT_SUPPORTED;
 
 	switch (feature) {
diff --git a/arch/arm64/kvm/trng.c b/arch/arm64/kvm/trng.c
index 99bdd7103c9c..89911b724a26 100644
--- a/arch/arm64/kvm/trng.c
+++ b/arch/arm64/kvm/trng.c
@@ -24,7 +24,7 @@ static const uuid_t arm_smc_trng_uuid __aligned(4) = UUID_INIT(
 static int kvm_trng_do_rnd(struct kvm_vcpu *vcpu, int size)
 {
 	DECLARE_BITMAP(bits, TRNG_MAX_BITS64);
-	u32 num_bits = smccc_get_arg1(vcpu);
+	u32 num_bits = smccc_get_arg(vcpu, 1);
 	int i;
 
 	if (num_bits > 3 * size) {
@@ -60,7 +60,7 @@ int kvm_trng_call(struct kvm_vcpu *vcpu)
 		val = ARM_SMCCC_TRNG_VERSION_1_0;
 		break;
 	case ARM_SMCCC_TRNG_FEATURES:
-		switch (smccc_get_arg1(vcpu)) {
+		switch (smccc_get_arg(vcpu, 1)) {
 		case ARM_SMCCC_TRNG_VERSION:
 		case ARM_SMCCC_TRNG_FEATURES:
 		case ARM_SMCCC_TRNG_GET_UUID:
diff --git a/include/kvm/arm_hypercalls.h b/include/kvm/arm_hypercalls.h
index 1188f116cf4e..ffd06387dfdf 100644
--- a/include/kvm/arm_hypercalls.h
+++ b/include/kvm/arm_hypercalls.h
@@ -8,24 +8,15 @@
 
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
 
-static inline u32 smccc_get_function(struct kvm_vcpu *vcpu)
-{
-	return vcpu_get_reg(vcpu, 0);
-}
-
-static inline unsigned long smccc_get_arg1(struct kvm_vcpu *vcpu)
+static inline unsigned long smccc_get_arg(struct kvm_vcpu *vcpu,
+					  unsigned char index)
 {
-	return vcpu_get_reg(vcpu, 1);
+	return vcpu_get_reg(vcpu, index);
 }
 
-static inline unsigned long smccc_get_arg2(struct kvm_vcpu *vcpu)
-{
-	return vcpu_get_reg(vcpu, 2);
-}
-
-static inline unsigned long smccc_get_arg3(struct kvm_vcpu *vcpu)
+static inline u32 smccc_get_function(struct kvm_vcpu *vcpu)
 {
-	return vcpu_get_reg(vcpu, 3);
+	return smccc_get_arg(vcpu, 0);
 }
 
 static inline void smccc_set_retval(struct kvm_vcpu *vcpu,
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
