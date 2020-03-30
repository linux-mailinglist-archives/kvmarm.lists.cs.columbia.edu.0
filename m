Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 38E9F1978D5
	for <lists+kvmarm@lfdr.de>; Mon, 30 Mar 2020 12:20:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C4B554B269;
	Mon, 30 Mar 2020 06:20:12 -0400 (EDT)
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
	with ESMTP id YB-RhCHNaDv2; Mon, 30 Mar 2020 06:20:12 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 870884B26F;
	Mon, 30 Mar 2020 06:20:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DDDF64B269
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Mar 2020 06:20:10 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id otaCeC6yLJEZ for <kvmarm@lists.cs.columbia.edu>;
 Mon, 30 Mar 2020 06:20:09 -0400 (EDT)
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [216.205.24.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id DDD3F4B266
 for <kvmarm@lists.cs.columbia.edu>; Mon, 30 Mar 2020 06:20:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585563609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6E/dAk2RnlJp9AQMbHdDVYq/j7w3RXnkQoUbm2tREo=;
 b=NY2uipgqmXJI5g174lTUvz1EaAsrNpp4E38e4xboYriYGfM6UrmbvdaCHGH3eM92Jcl7n/
 Xw7NPy63rN4XwpVPDVGHZNCvOZNPkp9Lo2JQeXMJohGZGvoaKC9zGNebBJyOjIrQHhz5Nf
 0x509QS9hK0FTw2OjlMRP8J0x4JQTAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-YRVcN6SzOI-iXKPBNOz4nw-1; Mon, 30 Mar 2020 06:20:05 -0400
X-MC-Unique: YRVcN6SzOI-iXKPBNOz4nw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88E5F1005509;
 Mon, 30 Mar 2020 10:20:03 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.172])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CDF61001925;
 Mon, 30 Mar 2020 10:19:57 +0000 (UTC)
Date: Mon, 30 Mar 2020 12:19:55 +0200
From: Andrew Jones <drjones@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v7 06/13] arm/arm64: ITS: Introspection
 tests
Message-ID: <20200330101955.2rlksuzkkvopk52t@kamzik.brq.redhat.com>
References: <20200320092428.20880-1-eric.auger@redhat.com>
 <20200320092428.20880-7-eric.auger@redhat.com>
 <947a79f5-1f79-532b-9ec7-6fd539ccd183@huawei.com>
 <8878be7f-7653-b427-cd0d-722f82fb6b65@redhat.com>
 <20200330091139.i2d6vv64f5diamlz@kamzik.brq.redhat.com>
 <7d6dc4e7-82b4-3c54-574f-2149d4a85c48@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7d6dc4e7-82b4-3c54-574f-2149d4a85c48@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: thuth@redhat.com, kvm@vger.kernel.org, maz@kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, andre.przywara@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Mon, Mar 30, 2020 at 11:56:00AM +0200, Auger Eric wrote:
> Hi,
> =

> On 3/30/20 11:11 AM, Andrew Jones wrote:
> > On Mon, Mar 30, 2020 at 10:46:57AM +0200, Auger Eric wrote:
> >> Hi Zenghui,
> >>
> >> On 3/30/20 10:30 AM, Zenghui Yu wrote:
> >>> Hi Eric,
> >>>
> >>> On 2020/3/20 17:24, Eric Auger wrote:
> >>>> +static void its_cmd_queue_init(void)
> >>>> +{
> >>>> +=A0=A0=A0 unsigned long order =3D get_order(SZ_64K >> PAGE_SHIFT);
> >>>> +=A0=A0=A0 u64 cbaser;
> >>>> +
> >>>> +=A0=A0=A0 its_data.cmd_base =3D (void *)virt_to_phys(alloc_pages(or=
der));
> >>>
> >>> Shouldn't the cmd_base (and the cmd_write) be set as a GVA?
> >> yes it should
> > =

> > If it's supposed to be a virtual address, when why do the virt_to_phys?
> What is programmed in CBASER register is a physical address. So the
> virt_to_phys() is relevant. The inconsistency is in its_allocate_entry()
> introduced later on where I return the physical address instead of the
> virtual address. I will fix that.
> =

> =

> > =

> >>>
> >>> Otherwise I think we will end-up with memory corruption when writing
> >>> the command queue.=A0 But it seems that everything just works fine ...
> >>> So I'm really confused here :-/
> >> I was told by Paolo that the VA/PA memory map is flat in kvmunit test.
> > =

> > What does flat mean?
> =

> Yes I meant an identity map.
> =

>  kvm-unit-tests, at least arm/arm64, does prepare
> > an identity map of all physical memory, which explains why the above
> > is working.
> =

> should be the same on x86

Maybe, but I didn't write or review how x86 does their default map, so I
don't know.

> =

>  It's doing virt_to_phys(some-virt-addr), which gets a
> > phys addr, but when the ITS uses it as a virt addr it works because
> > we *also* have a virt addr =3D=3D phys addr mapping in the default page
> > table, which is named "idmap" for good reason.
> > =

> > I think it would be better to test with the non-identity mapped address=
es
> > though.
> =

> is there any way to exercise a non idmap?

You could create your own map and then switch to it. See lib/arm/asm/mmu-ap=
i.h

But, you don't have to switch the whole map to use non-identity mapped
addresses. Just create new virt mappings to the phys addresses you're
interested in, and then use those new virt addresses instead. If you're
worried that somewhere an identity mapped virt address is getting used
because of a phys/virt address mix up, then you could probably sprinkle
some assert(virt_to_phys(addr) !=3D addr)'s around to ensure it.

Thanks,
drew

> =

> Thanks
> =

> Eric
> > =

> > Thanks,
> > drew
> > =

> >>
> >>>
> >>>> +
> >>>> +=A0=A0=A0 cbaser =3D ((u64)its_data.cmd_base | (SZ_64K / SZ_4K - 1)=
=A0=A0=A0 |
> >>>> GITS_CBASER_VALID);
> >>>> +
> >>>> +=A0=A0=A0 writeq(cbaser, its_data.base + GITS_CBASER);
> >>>> +
> >>>> +=A0=A0=A0 its_data.cmd_write =3D its_data.cmd_base;
> >>>> +=A0=A0=A0 writeq(0, its_data.base + GITS_CWRITER);
> >>>> +}
> >>>
> >>> Otherwise this looks good,
> >>> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
> >> Thanks!
> >>
> >> Eric
> >>>
> >>>
> >>> Thanks
> >>>
> >>
> >>
> =

> =


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
