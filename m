Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8B63C37A253
	for <lists+kvmarm@lfdr.de>; Tue, 11 May 2021 10:38:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1222C4B487;
	Tue, 11 May 2021 04:38:59 -0400 (EDT)
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
	with ESMTP id nDnNGD4l9TUX; Tue, 11 May 2021 04:38:58 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A99334B47C;
	Tue, 11 May 2021 04:38:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2DDCF4B392
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 May 2021 04:38:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v0Lkl8n3lTkd for <kvmarm@lists.cs.columbia.edu>;
 Tue, 11 May 2021 04:38:56 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0693E4B389
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 May 2021 04:38:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620722335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oAopTEbdD9SUh6PQTXI2MykT2T2jIRp0VGhtGVWodjg=;
 b=I9C6OlbcmXOMZOkN0/jLrZOqQ1B+Rf890chd7w6VaAKWOoI0nKTlHCPThla8IthEZMj6iz
 zNYnKvTpfrSjh6/22ZHLmF2RiHJhn1BfxxjIrSXRuczEcDjQRfPbToETKhFVxpsZZeKhGK
 Qo33zxiA30ezsYMg6ffxUj9vYPfG2pk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-B63qdTx4Ms6lyhxtVTsckQ-1; Tue, 11 May 2021 04:38:54 -0400
X-MC-Unique: B63qdTx4Ms6lyhxtVTsckQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 d8-20020a0564020008b0290387d38e3ce0so10535138edu.1
 for <kvmarm@lists.cs.columbia.edu>; Tue, 11 May 2021 01:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oAopTEbdD9SUh6PQTXI2MykT2T2jIRp0VGhtGVWodjg=;
 b=F1njuoGeRLQm9gIN5ut17zXWSR8IG+l244jHZi9yTSGOsyu4+15mDrLhHMQtnHUyIt
 8e2huNfVWuK5JRjo24hD6hc7cWyPmRsKNx+NVr++RxFIhG6kxAw9qNAxTeFbrtlTckea
 JNJ9YfN6nQBiXLQExXVdWrE4ejRmLsxNF6cMKxN8DbWw8VytlWQrJTt7ve7rWi37Jz7j
 5Pb6WkVFX+/or8xvRjQID3gsrsAqOQmQcldvIjMHYVYIQUSlcISz1WX9F27ci3BbMDgI
 EfSCN9dHQqsvy7xM3ntBkgCHiik/PHaCu11p8CEHTR9q0voZl40ppIphlBPn2SaqWCQ1
 VZGw==
X-Gm-Message-State: AOAM5309cLX8g6SW52Uky5GIO2dM35+7PnljSCZLiHqRXOLZvAsR+DTg
 KcDc7kPCJWZ4uesK4JxKFPXXYWaWf3UpUga5mEH0v/5uYEokdHozFKtc+TZ/Hzx0CRLIzbVeUeh
 fhe64BvpCeb6rYkzpnfY6HCLE
X-Received: by 2002:a17:906:9718:: with SMTP id
 k24mr1941020ejx.23.1620722332730; 
 Tue, 11 May 2021 01:38:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyT75fua4+WgIi/rgmXTzVvo4K8REfXZdDbFxcG2kK4Dqn2ZsdkeL1pgt+qT2yOLrXO7W/tLA==
X-Received: by 2002:a17:906:9718:: with SMTP id
 k24mr1940987ejx.23.1620722332520; 
 Tue, 11 May 2021 01:38:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id b21sm11083756ejg.80.2021.05.11.01.38.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 May 2021 01:38:51 -0700 (PDT)
Subject: Re: [PATCH v4 0/4] KVM statistics data fd-based binary interface
To: Jing Zhang <jingzhangos@google.com>, KVM <kvm@vger.kernel.org>,
 KVMARM <kvmarm@lists.cs.columbia.edu>, LinuxMIPS
 <linux-mips@vger.kernel.org>, KVMPPC <kvm-ppc@vger.kernel.org>,
 LinuxS390 <linux-s390@vger.kernel.org>,
 Linuxkselftest <linux-kselftest@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Paul Mackerras <paulus@ozlabs.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Claudio Imbrenda
 <imbrenda@linux.ibm.com>, Sean Christopherson <seanjc@google.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Jim Mattson <jmattson@google.com>,
 Peter Shier <pshier@google.com>, Oliver Upton <oupton@google.com>,
 David Rientjes <rientjes@google.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>
References: <20210429203740.1935629-1-jingzhangos@google.com>
 <CAAdAUtgW0vYmr5rqiMJKbZSjgEtLQqxfHd8H0fxrTbE0o4zmWw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cdf0a42f-c52b-bf79-5237-5f3b31077db7@redhat.com>
Date: Tue, 11 May 2021 10:38:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAAdAUtgW0vYmr5rqiMJKbZSjgEtLQqxfHd8H0fxrTbE0o4zmWw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 10/05/21 20:57, Jing Zhang wrote:
> Hi Paolo,
> 
> On Thu, Apr 29, 2021 at 3:37 PM Jing Zhang <jingzhangos@google.com> wrote:
>>
>> This patchset provides a file descriptor for every VM and VCPU to read
>> KVM statistics data in binary format.
>> It is meant to provide a lightweight, flexible, scalable and efficient
>> lock-free solution for user space telemetry applications to pull the
>> statistics data periodically for large scale systems. The pulling
>> frequency could be as high as a few times per second.
>> In this patchset, every statistics data are treated to have some
>> attributes as below:
>>    * architecture dependent or common
>>    * VM statistics data or VCPU statistics data
>>    * type: cumulative, instantaneous,
>>    * unit: none for simple counter, nanosecond, microsecond,
>>      millisecond, second, Byte, KiByte, MiByte, GiByte. Clock Cycles
>> Since no lock/synchronization is used, the consistency between all
>> the statistics data is not guaranteed. That means not all statistics
>> data are read out at the exact same time, since the statistics date
>> are still being updated by KVM subsystems while they are read out.
>>
>> ---
>>
>> * v3 -> v4
>>    - Rebase to kvm/queue, commit 9f242010c3b4 ("KVM: avoid "deadlock"
>>      between install_new_memslots and MMU notifier")
>>    - Use C-stype comments in the whole patch
>>    - Fix wrong count for x86 VCPU stats descriptors
>>    - Fix KVM stats data size counting and validity check in selftest
>>
>> * v2 -> v3
>>    - Rebase to kvm/queue, commit edf408f5257b ("KVM: avoid "deadlock"
>>      between install_new_memslots and MMU notifier")
>>    - Resolve some nitpicks about format
>>
>> * v1 -> v2
>>    - Use ARRAY_SIZE to count the number of stats descriptors
>>    - Fix missing `size` field initialization in macro STATS_DESC
>>
>> [1] https://lore.kernel.org/kvm/20210402224359.2297157-1-jingzhangos@google.com
>> [2] https://lore.kernel.org/kvm/20210415151741.1607806-1-jingzhangos@google.com
>> [3] https://lore.kernel.org/kvm/20210423181727.596466-1-jingzhangos@google.com
>>
>> ---
>>
>> Jing Zhang (4):
>>    KVM: stats: Separate common stats from architecture specific ones
>>    KVM: stats: Add fd-based API to read binary stats data
>>    KVM: stats: Add documentation for statistics data binary interface
>>    KVM: selftests: Add selftest for KVM statistics data binary interface
>>
>>   Documentation/virt/kvm/api.rst                | 171 ++++++++
>>   arch/arm64/include/asm/kvm_host.h             |   9 +-
>>   arch/arm64/kvm/guest.c                        |  42 +-
>>   arch/mips/include/asm/kvm_host.h              |   9 +-
>>   arch/mips/kvm/mips.c                          |  67 ++-
>>   arch/powerpc/include/asm/kvm_host.h           |   9 +-
>>   arch/powerpc/kvm/book3s.c                     |  68 +++-
>>   arch/powerpc/kvm/book3s_hv.c                  |  12 +-
>>   arch/powerpc/kvm/book3s_pr.c                  |   2 +-
>>   arch/powerpc/kvm/book3s_pr_papr.c             |   2 +-
>>   arch/powerpc/kvm/booke.c                      |  63 ++-
>>   arch/s390/include/asm/kvm_host.h              |   9 +-
>>   arch/s390/kvm/kvm-s390.c                      | 133 +++++-
>>   arch/x86/include/asm/kvm_host.h               |   9 +-
>>   arch/x86/kvm/x86.c                            |  71 +++-
>>   include/linux/kvm_host.h                      | 132 +++++-
>>   include/linux/kvm_types.h                     |  12 +
>>   include/uapi/linux/kvm.h                      |  50 +++
>>   tools/testing/selftests/kvm/.gitignore        |   1 +
>>   tools/testing/selftests/kvm/Makefile          |   3 +
>>   .../testing/selftests/kvm/include/kvm_util.h  |   3 +
>>   .../selftests/kvm/kvm_bin_form_stats.c        | 380 ++++++++++++++++++
>>   tools/testing/selftests/kvm/lib/kvm_util.c    |  11 +
>>   virt/kvm/kvm_main.c                           | 237 ++++++++++-
>>   24 files changed, 1415 insertions(+), 90 deletions(-)
>>   create mode 100644 tools/testing/selftests/kvm/kvm_bin_form_stats.c
>>
>>
>> base-commit: 9f242010c3b46e63bc62f08fff42cef992d3801b
>> --
>> 2.31.1.527.g47e6f16901-goog
>>
> 
> Do I need to send another version for this?

No, the merge window has just finished and I wanted to flush the dozens 
of bugfix patches that I had.  I'll get to it shortly.

Paolo

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
