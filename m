Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 218064275A5
	for <lists+kvmarm@lfdr.de>; Sat,  9 Oct 2021 04:12:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BA09449F5F;
	Fri,  8 Oct 2021 22:12:58 -0400 (EDT)
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
	with ESMTP id 0PK-AnENiamG; Fri,  8 Oct 2021 22:12:58 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D5A894B126;
	Fri,  8 Oct 2021 22:12:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A22344B0DF
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Oct 2021 22:12:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RLb9EKPcl845 for <kvmarm@lists.cs.columbia.edu>;
 Fri,  8 Oct 2021 22:12:55 -0400 (EDT)
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com
 [209.85.219.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CEDA94B0CB
 for <kvmarm@lists.cs.columbia.edu>; Fri,  8 Oct 2021 22:12:54 -0400 (EDT)
Received: by mail-yb1-f201.google.com with SMTP id
 v203-20020a25c5d4000000b005bb21580411so2357286ybe.19
 for <kvmarm@lists.cs.columbia.edu>; Fri, 08 Oct 2021 19:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=OSahwrCOM8hvTCjGSN0bryGWa8lO1ktrkgbUtpkiWTU=;
 b=M5Nnc+p8tzrX3sNy50+q4rLjDSCqSRYtbN8NDtIMtL5lz0M1RLPaDK9QbmYeZ771j6
 iFkLbm77/+6Yc0cSHxabd0QyOohOgtVklZfs3Cn2dN0a1ZwfX67QbT1JAQNLhjpc4+uO
 vi9O60Ie3T48wyOT5Z4Gu0fSaeBm6K+RcT5Zaus4zoWDP/z2bfzcS0MRP6qrM18VmvI1
 q2TtwZL4vCj4M6FLDBiRgBUXmYKIdxYeZUm1TBqJ6arSG1KgtQu+aFJsGYHUTkfjGQof
 tTaWlTLEfPIrKFJvjF0monIrG5PmtaBKUx6Tf3cXwYd6T3mEDwvkPUW8UU30Bw8nBP9y
 0gDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=OSahwrCOM8hvTCjGSN0bryGWa8lO1ktrkgbUtpkiWTU=;
 b=gYidk33K2AOY44EfRJvItzuLSI4ky2mCB3zBmo4hLcXSuLjT5hxIuaYieakZ/tKIQM
 gabe1g/gQnPfh+6eINP9glehgwBDLytGbQXvspUb70NHhjvfwipMakifYju3HEHhRyxS
 WgcVulCf1g2GvcSWvLNtarFecr/JqSvZyem9G2kEPETkmqqhIwKM/TuG7NYNBQ33tR+3
 6bMyZUSh4TQdZNJVk3iFHRmHH7rYDDpjrCbPpRC6D1IuDeCfG/CiLiAG+br0yOe7uCkw
 FCySPPMFjdpYdzmLlYc0YKXJbb89hwn4T7a4C8lDBci11VVhC6s8JO13Y8J/WlFBqpcr
 N/hQ==
X-Gm-Message-State: AOAM531XPraZyboZH5RaZZzppHjJJHFF4Dyx9xWGPV5zXbh7cng3hkze
 //uDWKL0Lza1W1mUaJfnl2k/TdrteMQ=
X-Google-Smtp-Source: ABdhPJx08F+X6N2reeGnFXth9S6Ys93QnEjCYVn+7HtsQKARH+T/4QlHmLInc1/XQW7XkZX+0RcLTuK00A4=
X-Received: from seanjc798194.pdx.corp.google.com
 ([2620:15c:90:200:e39b:6333:b001:cb])
 (user=seanjc job=sendgmr) by 2002:a05:6902:124e:: with SMTP id
 t14mr2047183ybu.221.1633745574354; Fri, 08 Oct 2021 19:12:54 -0700 (PDT)
Date: Fri,  8 Oct 2021 19:11:58 -0700
In-Reply-To: <20211009021236.4122790-1-seanjc@google.com>
Message-Id: <20211009021236.4122790-6-seanjc@google.com>
Mime-Version: 1.0
References: <20211009021236.4122790-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 05/43] KVM: Update halt-polling stats if and only if
 halt-polling was attempted
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paul Mackerras <paulus@ozlabs.org>, 
 Anup Patel <anup.patel@wdc.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Atish Patra <atish.patra@wdc.com>, linux-riscv@lists.infradead.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, kvmarm@lists.cs.columbia.edu,
 Joerg Roedel <joro@8bytes.org>, kvm-ppc@vger.kernel.org,
 David Matlack <dmatlack@google.com>, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>
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

Don't update halt-polling stats if halt-polling wasn't attempted.  This
is a nop as @poll_ns is guaranteed to be '0' (poll_end == start), but it
will allow a future patch to move the histogram stats into the helper to
resolve a discrepancy in what is considered a "successful" halt-poll.

No functional change intended.

Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5d4a90032277..6156719bcbbc 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3217,6 +3217,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 {
 	struct rcuwait *wait = kvm_arch_vcpu_get_wait(vcpu);
 	bool halt_poll_allowed = !kvm_arch_no_poll(vcpu);
+	bool do_halt_poll = halt_poll_allowed && vcpu->halt_poll_ns;
 	ktime_t start, cur, poll_end;
 	bool waited = false;
 	u64 block_ns;
@@ -3224,7 +3225,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 	kvm_arch_vcpu_blocking(vcpu);
 
 	start = cur = poll_end = ktime_get();
-	if (vcpu->halt_poll_ns && halt_poll_allowed) {
+	if (do_halt_poll) {
 		ktime_t stop = ktime_add_ns(ktime_get(), vcpu->halt_poll_ns);
 
 		++vcpu->stat.generic.halt_attempted_poll;
@@ -3276,8 +3277,9 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 	kvm_arch_vcpu_unblocking(vcpu);
 	block_ns = ktime_to_ns(cur) - ktime_to_ns(start);
 
-	update_halt_poll_stats(
-		vcpu, ktime_to_ns(ktime_sub(poll_end, start)), waited);
+	if (do_halt_poll)
+		update_halt_poll_stats(
+			vcpu, ktime_to_ns(ktime_sub(poll_end, start)), waited);
 
 	if (halt_poll_allowed) {
 		if (!vcpu_valid_wakeup(vcpu)) {
-- 
2.33.0.882.g93a45727a2-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
