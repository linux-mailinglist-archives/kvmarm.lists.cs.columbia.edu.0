Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 48C753CEB23
	for <lists+kvmarm@lfdr.de>; Mon, 19 Jul 2021 20:50:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E259E4B0F2;
	Mon, 19 Jul 2021 14:50:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7TlLnb-bw7NM; Mon, 19 Jul 2021 14:50:09 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E5A44B0FA;
	Mon, 19 Jul 2021 14:50:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D79CE4B0B1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Jul 2021 14:50:05 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qzzl9qPTFPDr for <kvmarm@lists.cs.columbia.edu>;
 Mon, 19 Jul 2021 14:50:04 -0400 (EDT)
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D7A174B0BE
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Jul 2021 14:50:03 -0400 (EDT)
Received: by mail-qv1-f74.google.com with SMTP id
 bk10-20020a05621406eab02902d1aac9c421so16151800qvb.1
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Jul 2021 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=gVY1OcKTRkdtAsXEWyCj2ppxRNB8jvE/V1F4Gd0MP+c=;
 b=rIe4EYIHZTwOJ/LUiUNHR7ZP9KqycOwxusCIiH31hPQqFcVGTBc1V7P3yBAW5nLMOf
 rVtsH9MK/R3IUquzLnJFycOUHo+NDeEQOzM3VNusblsfRBTvJvyA9sd/uVCjpaPYgN2Z
 Pqzh/O7c+NxCnojD2tFCdhNGFve1zeafT1c2aRlALZVA49Yfo4japt7RG6fVIAICydTj
 nAVp6rKK4uOqi8/bJIJm8Lkmta2iqxjy19MO47gej1GC/N5QLDS8F2hW84QKHy1HuqZo
 FOPG6e4fTJXX8F2b/SlCENE/xNxwWvK6F0wJDI3/YzAyW4CkWurni2c52QqsedvFxsJ2
 vwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=gVY1OcKTRkdtAsXEWyCj2ppxRNB8jvE/V1F4Gd0MP+c=;
 b=POVhsAkmcyFdG6KqBzaQg/6WrWVej6LyYWmQbTtG5FTe109mxGItEcpdlEcKusQbuF
 zLsmI95OVOu2+SJk0M1yD+Tz6Yx9+6dL1/vJdz4eu7P8m5+ehKwe13TOlwOh/YIEa+dE
 AbLtNLoRB3H/ejs2moaq7BGqAXRsBYVV5tNdHZxi6HF4vnrGqDOrsFYTSARyrIPOC/zA
 6PJHrjFazPhD0Y7D3pJwCvvfs89xNhLsfbqttp4yeR2qHClVq+zaW0krGwdPMMb6Wikj
 /B5yM67yfpMZq29S65epiTTcDj7WwAS928bI0CHQAb78360DfvHT3qYrNAxOJp+pOmMq
 IAEg==
X-Gm-Message-State: AOAM532yEmKN2qh8eqVYr33Y7Y0XXQUAk87yv7KqKaGxbFvpHB6sm6pb
 FLRDSzfsy2jNsly8kfo3hWd8GZ7aJ6c=
X-Google-Smtp-Source: ABdhPJwMtLpMckHH8SI1H19lvBkJcK8ZOjmQJ0hNe6s1ExY+akygtzdlgbYmN9GT8ZpsFuaNtAn7yVUJPzI=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a05:6214:16ca:: with SMTP id
 d10mr25973873qvz.59.1626720603342; Mon, 19 Jul 2021 11:50:03 -0700 (PDT)
Date: Mon, 19 Jul 2021 18:49:40 +0000
In-Reply-To: <20210719184949.1385910-1-oupton@google.com>
Message-Id: <20210719184949.1385910-4-oupton@google.com>
Mime-Version: 1.0
References: <20210719184949.1385910-1-oupton@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH v3 03/12] KVM: x86: Expose TSC offset controls to userspace
From: Oliver Upton <oupton@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: Marc Zyngier <maz@kernel.org>, Raghavendra Rao Anata <rananta@google.com>,
 Peter Shier <pshier@google.com>, Sean Christopherson <seanjc@google.com>,
 David Matlack <dmatlack@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Jim Mattson <jmattson@google.com>
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

To date, VMM-directed TSC synchronization and migration has been a bit
messy. KVM has some baked-in heuristics around TSC writes to infer if
the VMM is attempting to synchronize. This is problematic, as it depends
on host userspace writing to the guest's TSC within 1 second of the last
write.

A much cleaner approach to configuring the guest's views of the TSC is to
simply migrate the TSC offset for every vCPU. Offsets are idempotent,
and thus not subject to change depending on when the VMM actually
reads/writes values from/to KVM. The VMM can then read the TSC once with
KVM_GET_CLOCK to capture a (realtime, host_tsc) pair at the instant when
the guest is paused.

Cc: David Matlack <dmatlack@google.com>
Signed-off-by: Oliver Upton <oupton@google.com>
---
 Documentation/virt/kvm/devices/vcpu.rst |  57 ++++++++
 arch/x86/include/asm/kvm_host.h         |   1 +
 arch/x86/include/uapi/asm/kvm.h         |   4 +
 arch/x86/kvm/x86.c                      | 167 ++++++++++++++++++++++++
 4 files changed, 229 insertions(+)

diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt/kvm/devices/vcpu.rst
index 2acec3b9ef65..b46d5f742e69 100644
--- a/Documentation/virt/kvm/devices/vcpu.rst
+++ b/Documentation/virt/kvm/devices/vcpu.rst
@@ -161,3 +161,60 @@ Specifies the base address of the stolen time structure for this VCPU. The
 base address must be 64 byte aligned and exist within a valid guest memory
 region. See Documentation/virt/kvm/arm/pvtime.rst for more information
 including the layout of the stolen time structure.
+
+4. GROUP: KVM_VCPU_TSC_CTRL
+===========================
+
+:Architectures: x86
+
+4.1 ATTRIBUTE: KVM_VCPU_TSC_OFFSET
+
+:Parameters: 64-bit unsigned TSC offset
+
+Returns:
+
+	 ======= ======================================
+	 -EFAULT Error reading/writing the provided
+	 	 parameter address.
+	 -ENXIO  Attribute not supported
+	 ======= ======================================
+
+Specifies the guest's TSC offset relative to the host's TSC. The guest's
+TSC is then derived by the following equation:
+
+  guest_tsc = host_tsc + KVM_VCPU_TSC_OFFSET
+
+This attribute is useful for the precise migration of a guest's TSC. The
+following describes a possible algorithm to use for the migration of a
+guest's TSC:
+
+From the source VMM process:
+
+1. Invoke the KVM_GET_CLOCK ioctl to record the host TSC (t_0),
+   kvmclock nanoseconds (k_0), and realtime nanoseconds (r_0).
+
+2. Read the KVM_VCPU_TSC_OFFSET attribute for every vCPU to record the
+   guest TSC offset (off_n).
+
+3. Invoke the KVM_GET_TSC_KHZ ioctl to record the frequency of the
+   guest's TSC (freq).
+
+From the destination VMM process:
+
+4. Invoke the KVM_SET_CLOCK ioctl, providing the kvmclock nanoseconds
+   (k_0) and realtime nanoseconds (r_0) in their respective fields.
+   Ensure that the KVM_CLOCK_REALTIME flag is set in the provided
+   structure. KVM will advance the VM's kvmclock to account for elapsed
+   time since recording the clock values.
+
+5. Invoke the KVM_GET_CLOCK ioctl to record the host TSC (t_1) and
+   kvmclock nanoseconds (k_1).
+
+6. Adjust the guest TSC offsets for every vCPU to account for (1) time
+   elapsed since recording state and (2) difference in TSCs between the
+   source and destination machine:
+
+   new_off_n = t_0 + off_n = (k_1 - k_0) * freq - t_1
+
+7. Write the KVM_VCPU_TSC_OFFSET attribute for every vCPU with the
+   respective value derived in the previous step.
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3fb2b9270d01..5f2e909b83eb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1070,6 +1070,7 @@ struct kvm_arch {
 	u64 last_tsc_nsec;
 	u64 last_tsc_write;
 	u32 last_tsc_khz;
+	u64 last_tsc_offset;
 	u64 cur_tsc_nsec;
 	u64 cur_tsc_write;
 	u64 cur_tsc_offset;
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index a6c327f8ad9e..0b22e1e84e78 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -503,4 +503,8 @@ struct kvm_pmu_event_filter {
 #define KVM_PMU_EVENT_ALLOW 0
 #define KVM_PMU_EVENT_DENY 1
 
+/* for KVM_{GET,SET,HAS}_DEVICE_ATTR */
+#define KVM_VCPU_TSC_CTRL 0 /* control group for the timestamp counter (TSC) */
+#define   KVM_VCPU_TSC_OFFSET 0 /* attribute for the TSC offset */
+
 #endif /* _ASM_X86_KVM_H */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 580ba0e86687..9e7867410091 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2411,6 +2411,11 @@ static void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 l1_offset)
 	static_call(kvm_x86_write_tsc_offset)(vcpu, vcpu->arch.tsc_offset);
 }
 
+static u64 kvm_vcpu_read_tsc_offset(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.l1_tsc_offset;
+}
+
 static void kvm_vcpu_write_tsc_multiplier(struct kvm_vcpu *vcpu, u64 l1_multiplier)
 {
 	vcpu->arch.l1_tsc_scaling_ratio = l1_multiplier;
@@ -2467,6 +2472,7 @@ static void __kvm_synchronize_tsc(struct kvm_vcpu *vcpu, u64 offset, u64 tsc,
 	kvm->arch.last_tsc_nsec = ns;
 	kvm->arch.last_tsc_write = tsc;
 	kvm->arch.last_tsc_khz = vcpu->arch.virtual_tsc_khz;
+	kvm->arch.last_tsc_offset = offset;
 
 	vcpu->arch.last_guest_tsc = tsc;
 
@@ -4914,6 +4920,137 @@ static int kvm_set_guest_paused(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static int kvm_arch_tsc_has_attr(struct kvm_vcpu *vcpu,
+				 struct kvm_device_attr *attr)
+{
+	int r;
+
+	switch (attr->attr) {
+	case KVM_VCPU_TSC_OFFSET:
+		r = 0;
+		break;
+	default:
+		r = -ENXIO;
+	}
+
+	return r;
+}
+
+static int kvm_arch_tsc_get_attr(struct kvm_vcpu *vcpu,
+				 struct kvm_device_attr *attr)
+{
+	void __user *uaddr = (void __user *)attr->addr;
+	int r;
+
+	switch (attr->attr) {
+	case KVM_VCPU_TSC_OFFSET: {
+		u64 offset;
+
+		offset = kvm_vcpu_read_tsc_offset(vcpu);
+		r = -EFAULT;
+		if (copy_to_user(uaddr, &offset, sizeof(offset)))
+			break;
+
+		r = 0;
+		break;
+	}
+	default:
+		r = -ENXIO;
+	}
+
+	return r;
+}
+
+static int kvm_arch_tsc_set_attr(struct kvm_vcpu *vcpu,
+				 struct kvm_device_attr *attr)
+{
+	void __user *uaddr = (void __user *)attr->addr;
+	struct kvm *kvm = vcpu->kvm;
+	int r;
+
+	switch (attr->attr) {
+	case KVM_VCPU_TSC_OFFSET: {
+		u64 offset, tsc, ns;
+		unsigned long flags;
+		bool matched;
+
+		r = -EFAULT;
+		if (copy_from_user(&offset, uaddr, sizeof(offset)))
+			break;
+
+		raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
+
+		matched = (vcpu->arch.virtual_tsc_khz &&
+			   kvm->arch.last_tsc_khz == vcpu->arch.virtual_tsc_khz &&
+			   kvm->arch.last_tsc_offset == offset);
+
+		tsc = kvm_scale_tsc(vcpu, rdtsc(), vcpu->arch.l1_tsc_scaling_ratio) + offset;
+		ns = get_kvmclock_base_ns();
+
+		__kvm_synchronize_tsc(vcpu, offset, tsc, ns, matched);
+		raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
+
+		r = 0;
+		break;
+	}
+	default:
+		r = -ENXIO;
+	}
+
+	return r;
+}
+
+static int kvm_vcpu_ioctl_has_device_attr(struct kvm_vcpu *vcpu,
+					  struct kvm_device_attr *attr)
+{
+	int r;
+
+	switch (attr->group) {
+	case KVM_VCPU_TSC_CTRL:
+		r = kvm_arch_tsc_has_attr(vcpu, attr);
+		break;
+	default:
+		r = -ENXIO;
+		break;
+	}
+
+	return r;
+}
+
+static int kvm_vcpu_ioctl_get_device_attr(struct kvm_vcpu *vcpu,
+					  struct kvm_device_attr *attr)
+{
+	int r;
+
+	switch (attr->group) {
+	case KVM_VCPU_TSC_CTRL:
+		r = kvm_arch_tsc_get_attr(vcpu, attr);
+		break;
+	default:
+		r = -ENXIO;
+		break;
+	}
+
+	return r;
+}
+
+static int kvm_vcpu_ioctl_set_device_attr(struct kvm_vcpu *vcpu,
+					  struct kvm_device_attr *attr)
+{
+	int r;
+
+	switch (attr->group) {
+	case KVM_VCPU_TSC_CTRL:
+		r = kvm_arch_tsc_set_attr(vcpu, attr);
+		break;
+	default:
+		r = -ENXIO;
+		break;
+	}
+
+	return r;
+}
+
 static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 				     struct kvm_enable_cap *cap)
 {
@@ -5368,6 +5505,36 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		r = __set_sregs2(vcpu, u.sregs2);
 		break;
 	}
+	case KVM_HAS_DEVICE_ATTR: {
+		struct kvm_device_attr attr;
+
+		r = -EFAULT;
+		if (copy_from_user(&attr, argp, sizeof(attr)))
+			goto out;
+
+		r = kvm_vcpu_ioctl_has_device_attr(vcpu, &attr);
+		break;
+	}
+	case KVM_GET_DEVICE_ATTR: {
+		struct kvm_device_attr attr;
+
+		r = -EFAULT;
+		if (copy_from_user(&attr, argp, sizeof(attr)))
+			goto out;
+
+		r = kvm_vcpu_ioctl_get_device_attr(vcpu, &attr);
+		break;
+	}
+	case KVM_SET_DEVICE_ATTR: {
+		struct kvm_device_attr attr;
+
+		r = -EFAULT;
+		if (copy_from_user(&attr, argp, sizeof(attr)))
+			goto out;
+
+		r = kvm_vcpu_ioctl_set_device_attr(vcpu, &attr);
+		break;
+	}
 	default:
 		r = -EINVAL;
 	}
-- 
2.32.0.402.g57bb445576-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
