Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 895014053D3
	for <lists+kvmarm@lfdr.de>; Thu,  9 Sep 2021 15:20:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0EC884B15D;
	Thu,  9 Sep 2021 09:20:30 -0400 (EDT)
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
	with ESMTP id j43Wm24iwooV; Thu,  9 Sep 2021 09:20:29 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 27E2E4B136;
	Thu,  9 Sep 2021 09:20:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5AEDE4B10E
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Sep 2021 09:20:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id otfQKTcigLBe for <kvmarm@lists.cs.columbia.edu>;
 Thu,  9 Sep 2021 09:20:25 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5A2784B106
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Sep 2021 09:20:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631193625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IPz8rCaG1n5gmzRfNCxWNsl8VhshhGe4oboIWdB5nfY=;
 b=LSyxwV6+iGlPhkCoE0U1nIUQc4ofYtvinXc8xcq8eIzpUc9NZCbefS/fHPu71fruwGEakb
 CrTm/mrvIa4tH39zZiaVqmQdOzdaU/JlvdRyq49YWVckyeuzwsBto60W3dYzg7GpOilxoF
 oHL+cnY2Hf77jorO9EPoJniJimySTII=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-vQYR_yeBM4e_OR0uS-moxA-1; Thu, 09 Sep 2021 09:20:23 -0400
X-MC-Unique: vQYR_yeBM4e_OR0uS-moxA-1
Received: by mail-ed1-f70.google.com with SMTP id
 u2-20020aa7d982000000b003cda80fa659so954979eds.14
 for <kvmarm@lists.cs.columbia.edu>; Thu, 09 Sep 2021 06:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IPz8rCaG1n5gmzRfNCxWNsl8VhshhGe4oboIWdB5nfY=;
 b=fuFmap9MbPhS9ZxWGwpjPlyXxIcOPTgfNCnGcvlJNtU5T7v0rt+kMnBvnpF75pFv+h
 ANyQxXW3O9Fh3KRK+xk570qkvW1t+L0annJ34R2F3dOLyaWbb5PKMIt1WE2pHTsG02xu
 HDsp9dxvPYZs+TfQO5vx8bZXixx6x9NlGYoNLm33WfXjrGHM8aFHqYg/7+yEFx8L8eMv
 F/XutoovzAwtjoapsVuacudMwDE9MStNqJI4OipHK0b7l7CcW8/6RJiGpOOrPCFJyllP
 hdqXqOYbxtKVpCBBCGa/e51WP2Qkz54BOkFbTWTZkt/g3stoaTC8JMm4sWw/sAVeZ3UK
 OB5g==
X-Gm-Message-State: AOAM533AdY6iE8idV9YXqZsFQJK0/V+cmUjzD1W/xPJK1VJxYCMDHD/E
 4gTrntJBT4hc+wAeZAfn+no2mYo1rZA5QiTCZJiKJY+eYEhgi/Hql8I4CApPKs2ZPPP5Cu9O4lD
 wEbo6C2BpYRQ36F6BiuojfFUo
X-Received: by 2002:a17:906:1510:: with SMTP id
 b16mr3523483ejd.332.1631193622102; 
 Thu, 09 Sep 2021 06:20:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxltN+LLKBsItVnHF6jboBkL7BG/4gKE6eUK2+syXfEg8esfR9/Hha6iEqkMhy0wQUkBEbcyQ==
X-Received: by 2002:a17:906:1510:: with SMTP id
 b16mr3523459ejd.332.1631193621929; 
 Thu, 09 Sep 2021 06:20:21 -0700 (PDT)
Received: from gator (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
 by smtp.gmail.com with ESMTPSA id l16sm999043eje.67.2021.09.09.06.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Sep 2021 06:20:21 -0700 (PDT)
Date: Thu, 9 Sep 2021 15:20:19 +0200
From: Andrew Jones <drjones@redhat.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH v4 12/18] KVM: selftests: Keep track of the number of
 vCPUs for a VM
Message-ID: <20210909132019.etrlz2t7pes7bc2o@gator>
References: <20210909013818.1191270-1-rananta@google.com>
 <20210909013818.1191270-13-rananta@google.com>
MIME-Version: 1.0
In-Reply-To: <20210909013818.1191270-13-rananta@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Peter Shier <pshier@google.com>,
 linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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

On Thu, Sep 09, 2021 at 01:38:12AM +0000, Raghavendra Rao Ananta wrote:
> The host may want to know the number of vCPUs that were
> created for a particular VM (used in upcoming patches).
> Hence, include nr_vcpus as a part of 'struct kvm_vm' to
> keep track of vCPUs as and when they are added or
> deleted, and return to the caller via vm_get_nr_vcpus().
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  tools/testing/selftests/kvm/include/kvm_util.h      | 1 +
>  tools/testing/selftests/kvm/lib/kvm_util.c          | 7 +++++++
>  tools/testing/selftests/kvm/lib/kvm_util_internal.h | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 010b59b13917..d5d0ca919928 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -399,5 +399,6 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
>  
>  int vm_get_stats_fd(struct kvm_vm *vm);
>  int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid);
> +int vm_get_nr_vcpus(struct kvm_vm *vm);
>  
>  #endif /* SELFTEST_KVM_UTIL_H */
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 10a8ed691c66..1b5349b5132f 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -594,6 +594,7 @@ static void vm_vcpu_rm(struct kvm_vm *vm, struct vcpu *vcpu)
>  
>  	list_del(&vcpu->list);
>  	free(vcpu);
> +	vm->nr_vcpus--;
>  }
>  
>  void kvm_vm_release(struct kvm_vm *vmp)
> @@ -1143,6 +1144,7 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
>  
>  	/* Add to linked-list of VCPUs. */
>  	list_add(&vcpu->list, &vm->vcpus);
> +	vm->nr_vcpus++;
>  }
>  
>  /*
> @@ -2343,3 +2345,8 @@ int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid)
>  
>  	return ioctl(vcpu->fd, KVM_GET_STATS_FD, NULL);
>  }
> +
> +int vm_get_nr_vcpus(struct kvm_vm *vm)
> +{
> +	return vm->nr_vcpus;
> +}

nr_vcpus looks like useful library internal information, since the only
other way to get the number is to iterate the vcpu list. I'm not sure
if we need this vm_get_nr_vcpus() accessor for tests yet though. Maybe
it'll be more clear to me when I see how it's used.

Thanks,
drew

> diff --git a/tools/testing/selftests/kvm/lib/kvm_util_internal.h b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
> index a03febc24ba6..be4d852d2f3b 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util_internal.h
> +++ b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
> @@ -56,6 +56,7 @@ struct kvm_vm {
>  	unsigned int va_bits;
>  	uint64_t max_gfn;
>  	struct list_head vcpus;
> +	int nr_vcpus;
>  	struct userspace_mem_regions regions;
>  	struct sparsebit *vpages_valid;
>  	struct sparsebit *vpages_mapped;
> -- 
> 2.33.0.153.gba50c8fa24-goog
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
