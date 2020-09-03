Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 51C1825B9F2
	for <lists+kvmarm@lfdr.de>; Thu,  3 Sep 2020 07:00:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C51224B31A;
	Thu,  3 Sep 2020 01:00:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ML4pcPEZyKwv; Thu,  3 Sep 2020 01:00:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B3A1E4B2CB;
	Thu,  3 Sep 2020 01:00:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 86F124B1DD
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 01:00:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zurfrKWTB3Bx for <kvmarm@lists.cs.columbia.edu>;
 Thu,  3 Sep 2020 01:00:27 -0400 (EDT)
Received: from us-smtp-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com [207.211.31.120])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7CD234B1F4
 for <kvmarm@lists.cs.columbia.edu>; Thu,  3 Sep 2020 01:00:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599109227;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Erjn+okjugfCqf+kdI+3fYOoVqZwyxKZAWHPn/nf6DI=;
 b=eVCIdF4nXWNMEOR3f8/D4SFmiOuhKLi2pfBz4SNb/5MlCjs5pgh8qbugLQtXUPRL2FU/yv
 x04wIcOH85zf6AqBNCdl7ypBNvR4ltpfqLygfW1IyAFA4A8e0LHTjPnmpmvXjPV2lC6KFG
 EZBmMVQFqRuXc1X/MVkPtAdOqzcr5FU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-rz22YC0QNtafUFUL5sH0tA-1; Thu, 03 Sep 2020 01:00:25 -0400
X-MC-Unique: rz22YC0QNtafUFUL5sH0tA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA2AA100747E;
 Thu,  3 Sep 2020 05:00:23 +0000 (UTC)
Received: from [10.64.54.159] (vpn2-54-159.bne.redhat.com [10.64.54.159])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 737A560C0F;
 Thu,  3 Sep 2020 05:00:21 +0000 (UTC)
Subject: Re: [PATCH v3 18/21] KVM: arm64: Check the pgt instead of the pgd
 when modifying page-table
To: Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu
References: <20200825093953.26493-1-will@kernel.org>
 <20200825093953.26493-19-will@kernel.org>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <802004d9-a351-1028-1c02-e14255af8392@redhat.com>
Date: Thu, 3 Sep 2020 15:00:19 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200825093953.26493-19-will@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gshan@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: Gavin Shan <gshan@redhat.com>
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

Hi Will,

On 8/25/20 7:39 PM, Will Deacon wrote:
> In preparation for removing the 'pgd' field of 'struct kvm_s2_mmu',
> update the few remaining users to check the 'pgt' field instead.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Quentin Perret <qperret@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   arch/arm64/kvm/mmu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index cfbf32cae3a5..050eab71de31 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1813,7 +1813,7 @@ static int kvm_unmap_hva_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *dat
>   int kvm_unmap_hva_range(struct kvm *kvm,
>   			unsigned long start, unsigned long end, unsigned flags)
>   {
> -	if (!kvm->arch.mmu.pgd)
> +	if (!kvm->arch.mmu.pgt)
>   		return 0;
>   
>   	trace_kvm_unmap_hva_range(start, end);
> @@ -1876,7 +1876,7 @@ static int kvm_test_age_hva_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *
>   
>   int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
>   {
> -	if (!kvm->arch.mmu.pgd)
> +	if (!kvm->arch.mmu.pgt)
>   		return 0;
>   	trace_kvm_age_hva(start, end);
>   	return handle_hva_to_gpa(kvm, start, end, kvm_age_hva_handler, NULL);
> @@ -1884,7 +1884,7 @@ int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
>   
>   int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
>   {
> -	if (!kvm->arch.mmu.pgd)
> +	if (!kvm->arch.mmu.pgt)
>   		return 0;
>   	trace_kvm_test_age_hva(hva);
>   	return handle_hva_to_gpa(kvm, hva, hva + PAGE_SIZE,
> 

Thanks,
Gavin

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
