Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1D96761FB16
	for <lists+kvmarm@lfdr.de>; Mon,  7 Nov 2022 18:19:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5DF754B8B3;
	Mon,  7 Nov 2022 12:19:24 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RiCbL7+CcU3x; Mon,  7 Nov 2022 12:19:24 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 25D1A4B882;
	Mon,  7 Nov 2022 12:19:23 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 383D64B850
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Nov 2022 12:19:22 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rCQvMkMqW-sZ for <kvmarm@lists.cs.columbia.edu>;
 Mon,  7 Nov 2022 12:19:21 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 43A534B838
 for <kvmarm@lists.cs.columbia.edu>; Mon,  7 Nov 2022 12:19:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667841561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vj6jKgV57HR3Syp9+ASZUDM7wgYRBqwk96cC1Kgx8ZM=;
 b=Y/rWZ/O0smdPrggoVGxbHyobyVofoAoP3Y5PSGR4RC3j8Gz2pp2V6dtvUR3+fAL9nXFjFv
 JP5XiHnmawoslI5+J4BAWJNLoutvu0H0MZzApzE4bz6kc99reWjH1FKZzu6DU27AW0mPVd
 hC9/1YfzSSn9E8dJw+V0irhT2nEGBuA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-5I8FLPu2M7CS5gN_-WeOdA-1; Mon, 07 Nov 2022 12:19:15 -0500
X-MC-Unique: 5I8FLPu2M7CS5gN_-WeOdA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D34CF101A52A;
 Mon,  7 Nov 2022 17:19:14 +0000 (UTC)
Received: from localhost (unknown [10.39.193.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87685492B05;
 Mon,  7 Nov 2022 17:19:14 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Collingbourne <pcc@google.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v5 7/8] KVM: arm64: permit all VM_MTE_ALLOWED mappings
 with MTE enabled
In-Reply-To: <20221104011041.290951-8-pcc@google.com>
Organization: Red Hat GmbH
References: <20221104011041.290951-1-pcc@google.com>
 <20221104011041.290951-8-pcc@google.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 07 Nov 2022 18:19:13 +0100
Message-ID: <87cz9y3coe.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Cc: kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Steven Price <steven.price@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Peter Collingbourne <pcc@google.com>, Evgenii Stepanov <eugenis@google.com>
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

On Thu, Nov 03 2022, Peter Collingbourne <pcc@google.com> wrote:

> Certain VMMs such as crosvm have features (e.g. sandboxing) that depend
> on being able to map guest memory as MAP_SHARED. The current restriction
> on sharing MAP_SHARED pages with the guest is preventing the use of
> those features with MTE. Now that the races between tasks concurrently
> clearing tags on the same page have been fixed, remove this restriction.
>
> Note that this is a relaxation of the ABI.
>
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
> ---
>  arch/arm64/kvm/mmu.c | 8 --------
>  1 file changed, 8 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
