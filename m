Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E69534F0AE6
	for <lists+kvmarm@lfdr.de>; Sun,  3 Apr 2022 17:47:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 42AD74B293;
	Sun,  3 Apr 2022 11:47:37 -0400 (EDT)
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
	with ESMTP id U4sUEIh5SgL7; Sun,  3 Apr 2022 11:47:37 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E5D4C4B26A;
	Sun,  3 Apr 2022 11:47:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C07D4B1AB
 for <kvmarm@lists.cs.columbia.edu>; Sun,  3 Apr 2022 11:47:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nbsJqgqoOJOf for <kvmarm@lists.cs.columbia.edu>;
 Sun,  3 Apr 2022 11:47:33 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 590614B17B
 for <kvmarm@lists.cs.columbia.edu>; Sun,  3 Apr 2022 11:47:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649000853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGb1wvVClVIB5502nscW3b3M6oaGhW5PvhB4rV0GUWg=;
 b=P31yk2Pd7/Umi3oVq6vNTHK5+A9k/mqkeDxNKAYwWbJW2zQiMMxwwvlRw4Tr0iZwznhHbC
 AjmY1wMCKQuKo6eTPc8qKFftK1uxPN2/9IOrnWyQARxKr6zPjsRXudaxUqfvGWn9/4SaAP
 mYDDQiFWtrEe2ouYTzy1DC5BO4013MI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-3oMwTB21O2eg4adoNk9Kww-1; Sun, 03 Apr 2022 11:47:28 -0400
X-MC-Unique: 3oMwTB21O2eg4adoNk9Kww-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C391C2999B22;
 Sun,  3 Apr 2022 15:47:25 +0000 (UTC)
Received: from [10.72.12.82] (ovpn-12-82.pek2.redhat.com [10.72.12.82])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 046C2432498;
 Sun,  3 Apr 2022 15:47:11 +0000 (UTC)
Subject: Re: [PATCH v6 00/18] Support SDEI Virtualization
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
References: <20220403153911.12332-1-gshan@redhat.com>
Message-ID: <a3bf5b44-0ab8-fd85-5557-6c496fd68bc1@redhat.com>
Date: Sun, 3 Apr 2022 23:47:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220403153911.12332-1-gshan@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Cc: maz@kernel.org, linux-kernel@vger.kernel.org, eauger@redhat.com,
 shan.gavin@gmail.com, Jonathan.Cameron@huawei.com, pbonzini@redhat.com,
 vkuznets@redhat.com, will@kernel.org
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

On 4/3/22 11:38 PM, Gavin Shan wrote:
> This series intends to virtualize Software Delegated Exception Interface
> (SDEI), which is defined by DEN0054C (v1.1). It allows the hypervisor to
> deliver NMI-alike SDEI event to guest and it's needed by Async PF to
> deliver page-not-present notification from hypervisor to guest. The code
> and the required qemu changes can be found from:
> 
>     https://developer.arm.com/documentation/den0054/c
>     https://github.com/gwshan/linux    ("kvm/arm64_sdei")
>     https://github.com/gwshan/qemu     ("kvm/arm64_sdei")
> 
> The design is quite strightforward by following the specification. The
> (SDEI) events are classified into the shared and private ones according
> to their scope. The shared event is system or VM scoped, but the private
> event is vcpu scoped. This implementation doesn't support the shared
> event because all the needed events are private. Besides, the migration
> isn't supported by implementation and it's something to be supported
> in future.
> 
> There are several objects (data structures) introduced to help on the
> event registration, enablement, disablement, unregistration, reset,
> delivery and handling.
> 
>    * kvm_sdei_exposed_event
>      The event which are defined and exposed by KVM. The event can't
>      be registered until it's exposed. Besides, all the information
>      in this event can't be changed after it's exposed.
>      
>    * kvm_sdei_event
>      The events are created based on the exposed events. Their states
>      are changed when hypercalls are received or they are delivered
>      to guest for handling.
>      
>    * kvm_sdei_vcpu_context
>      The vcpu context helps to handle events. The interrupted context
>      is saved before the event handler is executed, and restored after
>      the event handler is to finish.
>      
>    * kvm_sdei_vcpu
>      Place holder for all objects for one particular VCPU.
> 
> The patches are organized as below:
> 
>    PATCH[01-02] Preparatory work to extend smccc_get_argx() and refactor
>                 hypercall routing mechanism
>    PATCH[03]    Adds SDEI virtualization infrastructure
>    PATCH[04-16] Supports various SDEI hypercalls and event handling
>    PATCH[17]    Exposes SDEI capability
>    PATCH[18]    Adds SDEI selftest case
>    
> The previous revisions can be found:
> 
>    v5: https://lore.kernel.org/kvmarm/20220322080710.51727-1-gshan@redhat.com/
>    v4: https://lore.kernel.org/kvmarm/20210815001352.81927-1-gshan@redhat.com/
>    v3: https://lore.kernel.org/kvmarm/20210507083124.43347-1-gshan@redhat.com/
>    v2: https://lore.kernel.org/kvmarm/20210209032733.99996-1-gshan@redhat.com/
>    v1: https://lore.kernel.org/kvmarm/20200817100531.83045-1-gshan@redhat.com/
> 

I'm explicitly copying Oliver, James, Mark and Shannon to avoid resending this series.
It seems they have been skipped even I explicitly copied them by 'git send-email --cc=<email-addr>'.

[...]

Thanks,
Gavin


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
