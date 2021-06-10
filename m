Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEC23A3079
	for <lists+kvmarm@lfdr.de>; Thu, 10 Jun 2021 18:23:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AA4524A1B0;
	Thu, 10 Jun 2021 12:23:29 -0400 (EDT)
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
	with ESMTP id 8hrV4ZXqd1kN; Thu, 10 Jun 2021 12:23:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7BBDA4A418;
	Thu, 10 Jun 2021 12:23:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 61C224A1FA
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Jun 2021 12:23:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WJ+ADZr4ZDFu for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Jun 2021 12:23:26 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8ADED406DD
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Jun 2021 12:23:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623342206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xaDYl3mAKqwxB1xdG6u3uJxh4rz2ERkYQsFm9BataQM=;
 b=I5ofZ6BwPSu8CG0vu1W1mD9eAYGffdRlfojToDh70eGXCA7HEyVEABTEUI5rx4OpGxYmt7
 xsugmYner0eBKowCG70jiyk+JEClomTFP6uLqZOoqK9nfWWs4TMgr/f7dy0iKGl32ft4O6
 dAEsNzPe0BqLeCbuMJi1TE7YoHr+Qb8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-h50xUkJAMb6X9a8fnPuGDQ-1; Thu, 10 Jun 2021 12:23:22 -0400
X-MC-Unique: h50xUkJAMb6X9a8fnPuGDQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 n21-20020a7bcbd50000b02901a2ee0826aeso4067948wmi.7
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Jun 2021 09:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xaDYl3mAKqwxB1xdG6u3uJxh4rz2ERkYQsFm9BataQM=;
 b=KTn5OyETMwEphqQao5FmF5NimUe/Oq70H2+2txLXxqKnXsrl0QUE99tXXxy/O4v0bc
 9eTUvZ9meKZH3a0svaC7kNqmtf9G5yvFcfi1w/dr1pgtKIdnxvP4G/TZkn+6zhifrQPP
 zHT//zJrHVZbx/HDnRCXZSgYN1D1ntPd5aRXwqt95mcwtrJvkU3eMx7Hst+SzCQ79OUo
 4qIyEBxes7pyYFW53O7O5ny0CkDL9BvM+vKmSTbFMjihb3oLuvqSe8Cy8REKtDkunRKw
 oUq/xmJUOIiEQzmhWrOjG7EZOU8dIrd56ijFsWbTVxC2Xn/OAcb2jnGh1EdyaMV2Be7V
 SdTA==
X-Gm-Message-State: AOAM533lEereUWLJlmoffyZJK4RScFGlkNKurxmWWPF/QwY+Rp+JfS3U
 yOxt6SafoqvWhLJ/8MO2B5aTx6/1ChOMYI0kWjMa+TgclTWMdQgkeaQPdkeC982l5i0SF3363uN
 hkaBcwCs7nHDUxp0Ko00KhkGA
X-Received: by 2002:adf:de91:: with SMTP id w17mr6484933wrl.352.1623342201751; 
 Thu, 10 Jun 2021 09:23:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzimm0IhzRGX0own3XmAQS7AEY/ooW0Iee1AKpx0NvxC3qE+jaJNCMXAZvHTl29Jx/k7NJRTg==
X-Received: by 2002:adf:de91:: with SMTP id w17mr6484880wrl.352.1623342201486; 
 Thu, 10 Jun 2021 09:23:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a?
 ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
 by smtp.gmail.com with ESMTPSA id o9sm3760703wri.68.2021.06.10.09.23.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jun 2021 09:23:20 -0700 (PDT)
Subject: Re: [PATCH v7 2/4] KVM: stats: Add fd-based API to read binary stats
 data
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
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 David Matlack <dmatlack@google.com>, Ricardo Koller <ricarkol@google.com>,
 Krish Sadhukhan <krish.sadhukhan@oracle.com>
References: <20210603211426.790093-1-jingzhangos@google.com>
 <20210603211426.790093-3-jingzhangos@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e3b2b3ab-88a2-827c-7775-10be63158ff3@redhat.com>
Date: Thu, 10 Jun 2021 18:23:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210603211426.790093-3-jingzhangos@google.com>
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

On 03/06/21 23:14, Jing Zhang wrote:
> +#define DEFINE_VM_STATS_DESC(...) {					       \
> +	STATS_DESC_COUNTER("remote_tlb_flush"),				       \
> +	## __VA_ARGS__							       \
> +}
> +
> +#define DEFINE_VCPU_STATS_DESC(...) {					       \
> +	STATS_DESC_COUNTER("halt_successful_poll"),			       \
> +	STATS_DESC_COUNTER("halt_attempted_poll"),			       \
> +	STATS_DESC_COUNTER("halt_poll_invalid"),			       \
> +	STATS_DESC_COUNTER("halt_wakeup"),				       \
> +	STATS_DESC_TIME_NSEC("halt_poll_success_ns"),			       \
> +	STATS_DESC_TIME_NSEC("halt_poll_fail_ns"),			       \
> +	## __VA_ARGS__							       \

Let's instead put this (note it's without braces) in macros like these

#define KVM_GENERIC_VM_STATS()							\
	STATS_DESC_COUNTER("remote_tlb_flush"),

#define KVM_GENERIC_VCPU_STATS(...)						\
	STATS_DESC_COUNTER("halt_successful_poll"),				\
	STATS_DESC_COUNTER("halt_attempted_poll"),				\
	STATS_DESC_COUNTER("halt_poll_invalid"),				\
	STATS_DESC_COUNTER("halt_wakeup"),					\
	STATS_DESC_TIME_NSEC("halt_poll_success_ns"),				\
	STATS_DESC_TIME_NSEC("halt_poll_fail_ns"),

and it can be used in the arch files.  In fact it can even be added in patch 1 and
switched to STATS_DESC_* here.

Paolo

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
