Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1233D45EDF2
	for <lists+kvmarm@lfdr.de>; Fri, 26 Nov 2021 13:34:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 963F04B108;
	Fri, 26 Nov 2021 07:34:01 -0500 (EST)
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
	with ESMTP id 7YRV0QWC4J1s; Fri, 26 Nov 2021 07:34:01 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1CFAE4B0E6;
	Fri, 26 Nov 2021 07:34:00 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 07AC84B0B4
 for <kvmarm@lists.cs.columbia.edu>; Fri, 26 Nov 2021 07:33:58 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sec41yko8znB for <kvmarm@lists.cs.columbia.edu>;
 Fri, 26 Nov 2021 07:33:57 -0500 (EST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2F08D4B08E
 for <kvmarm@lists.cs.columbia.edu>; Fri, 26 Nov 2021 07:33:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637930037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VPzVgc0AYP+sKhBkiolAFzffLls+sRar8XWgazVePtA=;
 b=WD3Mw0tTVQ5GpDSlQewA62FEaVliiY2PNT2H0bPa4QVHl1ncbBKlKbFp7qThesrEx65L4H
 VDzNVwRaj/MyBv6JGuT2+zueUEHGSKsULDlotGcz94dlTfxrlH9hsyWVLOYkHh0minnYsx
 neWiCWbReor072FA/2TLA77YMofYDyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-lecbiigyPvSggTsjaZoCPA-1; Fri, 26 Nov 2021 07:33:53 -0500
X-MC-Unique: lecbiigyPvSggTsjaZoCPA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4AAA81CCB7;
 Fri, 26 Nov 2021 12:33:51 +0000 (UTC)
Received: from [10.39.195.16] (unknown [10.39.195.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 467C55D6B1;
 Fri, 26 Nov 2021 12:33:40 +0000 (UTC)
Message-ID: <086c9553-6ba1-411b-43db-b51670798938@redhat.com>
Date: Fri, 26 Nov 2021 13:33:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5.5 00/30] KVM: Scalable memslots implementation
Content-Language: en-US
To: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
References: <20211104002531.1176691-1-seanjc@google.com>
 <cb4f5d6e-9535-dd57-d8ee-3b593a81f3a6@oracle.com>
 <YYnNA5lZNXXdX/ig@google.com>
 <f3bc3bfc-37c3-bbfd-25b4-ef0a72e534ba@oracle.com>
 <5129f02d-7c0e-8e88-797f-95e8d968df88@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <5129f02d-7c0e-8e88-797f-95e8d968df88@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, linux-mips@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
 Ben Gardon <bgardon@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>
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

On 11/23/21 15:42, Maciej S. Szmigiero wrote:
> Paolo,
> 
> I see that you have merged the whole series to kvm/queue, even though it
> still needed some changes and, most importantly, a good round of testing.
> 
> Does this mean you want all these changes as a separate patch set on top
> of the already-merged series?

Hi Maciej,

you can squash your changes and post a v6.

Paolo

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
