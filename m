Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D2BB41238EA
	for <lists+kvmarm@lfdr.de>; Tue, 17 Dec 2019 22:56:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 13EA54A3BF;
	Tue, 17 Dec 2019 16:56:49 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id snNatAqOqfEQ; Tue, 17 Dec 2019 16:56:48 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B3A2E4A59B;
	Tue, 17 Dec 2019 16:56:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B40E14A3BF
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Dec 2019 16:56:46 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r4bK5egSD97n for <kvmarm@lists.cs.columbia.edu>;
 Tue, 17 Dec 2019 16:56:45 -0500 (EST)
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 740D84A3A3
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Dec 2019 16:56:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576619805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y9EmI3Nr90MB39kVEiie1LgWNRBdKLDpuM1lu03ZacU=;
 b=gY5rR61HOKGxHDO6PTJL1Kwnm5AqdIIb0ntY0IElantXglWdwJKkEiyrdEhnu7RdS57pgS
 rMb+kQQG75SBlioJu8Ql5pO76p/oNRMYIuHXUFro/e71BZ830kGp91wBaSUkSo7bjEbg8p
 e3Ya9eO03yAj4vF06J3CZxBBVSt50Vo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-p3b4T9aGPZGQZ369s923pg-1; Tue, 17 Dec 2019 16:56:43 -0500
Received: by mail-qk1-f199.google.com with SMTP id g28so7833895qkl.6
 for <kvmarm@lists.cs.columbia.edu>; Tue, 17 Dec 2019 13:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hSE8d84YfV0TRBuqIE3TvHfXXVwzC5/7L6224fyao4A=;
 b=sjM90n6Q7OKITjUOLJgXUM+HcpBj08Br6Y2I9IhySg/QYybIFks8SW8A7j1kR82cyt
 VysADocT4y7LxFICkDJvOVediri66cVRwWq/Q8L4vyBqRWLLhyZICyMAX/VNglZM94sM
 dHB51dBsp+dJlgsg6SRbEDfHB/FHz3GjeLqUNXmLUrL8y0slvK4cHfkUHYqm/dEJ7ZyL
 PTgCWsU8UdOq0zl56MShx9RAovXLwnJvhz5mD86TErvedWgHCpEORavHOWGlPDqeWd38
 lVieA17yVHhThQE8qodlufRHAMM8g8N0jrCS4p3AE/rizrqH3l3JlWL0/02A2QwxfoQH
 LXGg==
X-Gm-Message-State: APjAAAV7OQ4DlE9h0YGKDlfd4PmYK99pl8ZlYdnCU3JwGMslaUbfXObn
 Tnyn4G1CKwiQUHY3kkqCv00VRw+N/ZWpZF9d8tY4dSaoodmqj9aUHKGACE4lK95OlqAmHUI0QIB
 MQ1RTVHzcEPdFe3CxBiDSltFR
X-Received: by 2002:a05:6214:707:: with SMTP id
 b7mr6932302qvz.97.1576619803180; 
 Tue, 17 Dec 2019 13:56:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxkJVTx6R82PYxH8CBMYAk4P1dJ5EjDAy6gossam+XsRnSgvrFRKTM01bOCNWxLxn1nVLa7oA==
X-Received: by 2002:a05:6214:707:: with SMTP id
 b7mr6932279qvz.97.1576619802834; 
 Tue, 17 Dec 2019 13:56:42 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id t198sm7534281qke.6.2019.12.17.13.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 13:56:41 -0800 (PST)
Date: Tue, 17 Dec 2019 16:56:40 -0500
From: Peter Xu <peterx@redhat.com>
To: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v4 01/19] KVM: x86: Allocate new rmap and large page
 tracking when moving memslot
Message-ID: <20191217215640.GI7258@xz-x1>
References: <20191217204041.10815-1-sean.j.christopherson@intel.com>
 <20191217204041.10815-2-sean.j.christopherson@intel.com>
MIME-Version: 1.0
In-Reply-To: <20191217204041.10815-2-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-MC-Unique: p3b4T9aGPZGQZ369s923pg-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: Wanpeng Li <wanpengli@tencent.com>, Janosch Frank <frankja@linux.ibm.com>,
 kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 James Hogan <jhogan@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 kvm-ppc@vger.kernel.org, linux-mips@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Marc Zyngier <maz@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvmarm@lists.cs.columbia.edu,
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

On Tue, Dec 17, 2019 at 12:40:23PM -0800, Sean Christopherson wrote:
> Reallocate a rmap array and recalcuate large page compatibility when
> moving an existing memslot to correctly handle the alignment properties
> of the new memslot.  The number of rmap entries required at each level
> is dependent on the alignment of the memslot's base gfn with respect to
> that level, e.g. moving a large-page aligned memslot so that it becomes
> unaligned will increase the number of rmap entries needed at the now
> unaligned level.
> 
> Not updating the rmap array is the most obvious bug, as KVM accesses
> garbage data beyond the end of the rmap.  KVM interprets the bad data as
> pointers, leading to non-canonical #GPs, unexpected #PFs, etc...
> 
>   general protection fault: 0000 [#1] SMP
>   CPU: 0 PID: 1909 Comm: move_memory_reg Not tainted 5.4.0-rc7+ #139
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>   RIP: 0010:rmap_get_first+0x37/0x50 [kvm]
>   Code: <48> 8b 3b 48 85 ff 74 ec e8 6c f4 ff ff 85 c0 74 e3 48 89 d8 5b c3
>   RSP: 0018:ffffc9000021bbc8 EFLAGS: 00010246
>   RAX: ffff00617461642e RBX: ffff00617461642e RCX: 0000000000000012
>   RDX: ffff88827400f568 RSI: ffffc9000021bbe0 RDI: ffff88827400f570
>   RBP: 0010000000000000 R08: ffffc9000021bd00 R09: ffffc9000021bda8
>   R10: ffffc9000021bc48 R11: 0000000000000000 R12: 0030000000000000
>   R13: 0000000000000000 R14: ffff88827427d700 R15: ffffc9000021bce8
>   FS:  00007f7eda014700(0000) GS:ffff888277a00000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00007f7ed9216ff8 CR3: 0000000274391003 CR4: 0000000000162eb0
>   Call Trace:
>    kvm_mmu_slot_set_dirty+0xa1/0x150 [kvm]
>    __kvm_set_memory_region.part.64+0x559/0x960 [kvm]
>    kvm_set_memory_region+0x45/0x60 [kvm]
>    kvm_vm_ioctl+0x30f/0x920 [kvm]
>    do_vfs_ioctl+0xa1/0x620
>    ksys_ioctl+0x66/0x70
>    __x64_sys_ioctl+0x16/0x20
>    do_syscall_64+0x4c/0x170
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   RIP: 0033:0x7f7ed9911f47
>   Code: <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 21 6f 2c 00 f7 d8 64 89 01 48
>   RSP: 002b:00007ffc00937498 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>   RAX: ffffffffffffffda RBX: 0000000001ab0010 RCX: 00007f7ed9911f47
>   RDX: 0000000001ab1350 RSI: 000000004020ae46 RDI: 0000000000000004
>   RBP: 000000000000000a R08: 0000000000000000 R09: 00007f7ed9214700
>   R10: 00007f7ed92149d0 R11: 0000000000000246 R12: 00000000bffff000
>   R13: 0000000000000003 R14: 00007f7ed9215000 R15: 0000000000000000
>   Modules linked in: kvm_intel kvm irqbypass
>   ---[ end trace 0c5f570b3358ca89 ]---
> 
> The disallow_lpage tracking is more subtle.  Failure to update results
> in KVM creating large pages when it shouldn't, either due to stale data
> or again due to indexing beyond the end of the metadata arrays, which
> can lead to memory corruption and/or leaking data to guest/userspace.
> 
> Note, the arrays for the old memslot are freed by the unconditional call
> to kvm_free_memslot() in __kvm_set_memory_region().
> 
> Fixes: 05da45583de9b ("KVM: MMU: large page support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

I think the error-prone part is:

	new = old = *slot;

Where IMHO it would be better if we only copy pointers explicitly when
under control, rather than blindly copying all the pointers in the
structure which even contains sub-structures.

For example, I see PPC has this:

struct kvm_arch_memory_slot {
#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
	unsigned long *rmap;
#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
};

I started to look into HV code of it a bit, then I see...

 - kvm_arch_create_memslot(kvmppc_core_create_memslot_hv) init slot->arch.rmap,
 - kvm_arch_flush_shadow_memslot(kvmppc_core_flush_memslot_hv) didn't free it,
 - kvm_arch_prepare_memory_region(kvmppc_core_prepare_memory_region_hv) is nop.

So Does it have similar issue?

-- 
Peter Xu

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
