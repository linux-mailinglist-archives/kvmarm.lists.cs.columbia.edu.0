Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 59D6051FD0E
	for <lists+kvmarm@lfdr.de>; Mon,  9 May 2022 14:40:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 978C94B303;
	Mon,  9 May 2022 08:40:45 -0400 (EDT)
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
	with ESMTP id 1NmShCOQfpWz; Mon,  9 May 2022 08:40:45 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 171604B2E9;
	Mon,  9 May 2022 08:40:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3A3254B2DF
 for <kvmarm@lists.cs.columbia.edu>; Mon,  9 May 2022 08:40:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YCqPiuInMyI3 for <kvmarm@lists.cs.columbia.edu>;
 Mon,  9 May 2022 08:40:41 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 223884B0C2
 for <kvmarm@lists.cs.columbia.edu>; Mon,  9 May 2022 08:40:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652100040;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SUadK35yMNXsZHcgs6kL1o+WcgWzTvpYsG0KVUtggWM=;
 b=UFfLwrxuQq6JenevjXw5y8vkSI9N/LJmcCOojv7WGKhejolDnGEW3tUOSNY08fkyoBex0M
 OKJTKhFMd4+Cy4JofjJsDfrZ/bl61s6OCxvaAdcviBDUc95tTf31HiKV1YYZ78dk6rB8o9
 VYzGZ1Iy2XkUYfiqtxVH3isKeCpz3Mk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-YHFrsFkoPgmqxOJw2FcZiA-1; Mon, 09 May 2022 08:40:37 -0400
X-MC-Unique: YHFrsFkoPgmqxOJw2FcZiA-1
Received: by mail-wr1-f72.google.com with SMTP id
 w20-20020adfd1b4000000b0020cbb4347e6so2186428wrc.17
 for <kvmarm@lists.cs.columbia.edu>; Mon, 09 May 2022 05:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
 :subject:content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=SUadK35yMNXsZHcgs6kL1o+WcgWzTvpYsG0KVUtggWM=;
 b=jVw0Ze2FLLq52lVCgmSUX4Vs2VO1HcqYepzSAIAg8qjf6JoSLPJuHK+Uvo3XhNhhmc
 7OcFKoVTXo96yjZSFoCHV2ilFFHLWTTyKEQHJWFSXV3xxl8mMhTjtscS9LtF25uVFDjT
 9YAWFGMMSAvc3QYX+AD3b3M7zIgZmoSobwW6PR8J7tEPKd3/EIfQ/M8ZajvadU4Eijim
 xyzKq6nuGgWTCivPJCOHlEhfM9Ke+nzpjmor2wfDdQOBp0qbRr6UqdVrqmezogCfuFci
 Urdgn9sOKGslGoU0fYFEdFGqDwuYZr/rLji7C9iubArpU1Be20KOwD7ZW7D0XM3XSa1W
 nBrA==
X-Gm-Message-State: AOAM532ot1DLHQPNpNAZ+VIeweGwY5nHByxBpOiBOJlGonRipm5ITkKC
 wGYzTtVM7VM5Yp4I8pIK0NlDe4Ety9ua5wUexUlepqgjgnCEyon6xRi5CEuf3bWd51qpKeoigJJ
 /juJKTrYgbxRLBxm8XlBEu4P4
X-Received: by 2002:a5d:47ca:0:b0:20c:72c9:d3be with SMTP id
 o10-20020a5d47ca000000b0020c72c9d3bemr13474747wrc.114.1652100036449; 
 Mon, 09 May 2022 05:40:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysvm3jkrqazePjRtdEnYu3kQ2p9NT6qTIcb4srvAfJimbVAhgFFtMASqJqwQfcuURt7qkeXg==
X-Received: by 2002:a5d:47ca:0:b0:20c:72c9:d3be with SMTP id
 o10-20020a5d47ca000000b0020c72c9d3bemr13474718wrc.114.1652100036144; 
 Mon, 09 May 2022 05:40:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a7bc24f000000b003942a244ecfsm12770414wmj.20.2022.05.09.05.40.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 May 2022 05:40:35 -0700 (PDT)
Message-ID: <20a4ca70-0dd5-75eb-0d09-234e3dceea40@redhat.com>
Date: Mon, 9 May 2022 14:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 2/4] KVM: arm64: vgic: Add more checks when restoring
 ITS tables
To: Ricardo Koller <ricarkol@google.com>
References: <20220427184814.2204513-1-ricarkol@google.com>
 <20220427184814.2204513-3-ricarkol@google.com>
 <b29fcba7-2599-bf1b-0720-26b05cc37fd4@redhat.com>
 <YnKxbNuf4U1Zgjx5@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <YnKxbNuf4U1Zgjx5@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, andre.przywara@arm.com, pshier@google.com,
 maz@kernel.org, pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
Reply-To: eric.auger@redhat.com
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

Hi Ricardo,

On 5/4/22 19:01, Ricardo Koller wrote:
> On Tue, May 03, 2022 at 07:14:19PM +0200, Eric Auger wrote:
>> Hi Ricardo,
>>
>> On 4/27/22 20:48, Ricardo Koller wrote:
>>> Try to improve the predictability of ITS save/restores (and debuggability
>>> of failed ITS saves) by failing early on restore when trying to read
>>> corrupted tables.
>>>
>>> Restoring the ITS tables does some checks for corrupted tables, but not as
>>> many as in a save: an overflowing device ID will be detected on save but
>>> not on restore.  The consequence is that restoring a corrupted table won't
>>> be detected until the next save; including the ITS not working as expected
>>> after the restore.  As an example, if the guest sets tables overlapping
>>> each other, which would most likely result in some corrupted table, this is
>>> what we would see from the host point of view:
>>>
>>> 	guest sets base addresses that overlap each other
>>> 	save ioctl
>>> 	restore ioctl
>>> 	save ioctl (fails)
>>>
>>> Ideally, we would like the first save to fail, but overlapping tables could
>>> actually be intended by the guest. So, let's at least fail on the restore
>>> with some checks: like checking that device and event IDs don't overflow
>>> their tables.
>>>
>>> Signed-off-by: Ricardo Koller <ricarkol@google.com>
>>> ---
>>>  arch/arm64/kvm/vgic/vgic-its.c | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
>>> index e14790750958..fb2d26a73880 100644
>>> --- a/arch/arm64/kvm/vgic/vgic-its.c
>>> +++ b/arch/arm64/kvm/vgic/vgic-its.c
>>> @@ -2198,6 +2198,12 @@ static int vgic_its_restore_ite(struct vgic_its *its, u32 event_id,
>>>  	if (!collection)
>>>  		return -EINVAL;
>>>  
>>> +	if (find_ite(its, dev->device_id, event_id))
>>> +		return -EINVAL;
>> Unsure about that. Nothing in the arm-vgic-its.rst doc says that the
>> KVM_DEV_ARM_ITS_RESTORE_TABLES ioctl cannot be called several times
>> (although obviously useless)
> In that case, maybe we could ignore the new repeated entry? or
Maybe you can fail only in the case the ITE to be restored is different
from the existing one? otherwise ignore.

Eric
> overwrite the old one?  find_ite() only returns the first (device_id,
> event_id) match. So, it's like the new one is ignored already.  The
> arm arm says this about MAPI commands in this situation:
>
>     If there is an existing mapping for the EventID-DeviceID
>     combination, behavior is UNPREDICTABLE.
>
> And, just in case, the main reason for adding this check was to avoid
> failing the next ITS save. The idea is to try to fail as soon as
> possible, not in possibly many days during the next migration attempt.
>
>>> +
>>> +	if (!vgic_its_check_event_id(its, dev, event_id))
>>> +		return -EINVAL;
>>> +
>>>  	ite = vgic_its_alloc_ite(dev, collection, event_id);
>>>  	if (IS_ERR(ite))
>>>  		return PTR_ERR(ite);
>>> @@ -2319,6 +2325,7 @@ static int vgic_its_restore_dte(struct vgic_its *its, u32 id,
>>>  				void *ptr, void *opaque)
>>>  {
>>>  	struct its_device *dev;
>>> +	u64 baser = its->baser_device_table;
>>>  	gpa_t itt_addr;
>>>  	u8 num_eventid_bits;
>>>  	u64 entry = *(u64 *)ptr;
>>> @@ -2339,6 +2346,12 @@ static int vgic_its_restore_dte(struct vgic_its *its, u32 id,
>>>  	/* dte entry is valid */
>>>  	offset = (entry & KVM_ITS_DTE_NEXT_MASK) >> KVM_ITS_DTE_NEXT_SHIFT;
>>>  
>>> +	if (find_its_device(its, id))
>>> +		return -EINVAL;
>> same here.
>>> +
>>> +	if (!vgic_its_check_id(its, baser, id, NULL))
>>> +		return -EINVAL;
>>> +
>>>  	dev = vgic_its_alloc_device(its, id, itt_addr, num_eventid_bits);
>>>  	if (IS_ERR(dev))
>>>  		return PTR_ERR(dev);
>> Thanks
>>
>> Eric
>>
> Thanks,
> Ricardo
>

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
