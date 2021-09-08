Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC83403664
	for <lists+kvmarm@lfdr.de>; Wed,  8 Sep 2021 10:53:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CF16C4B105;
	Wed,  8 Sep 2021 04:53:52 -0400 (EDT)
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
	with ESMTP id 4JI1SUiEZp7E; Wed,  8 Sep 2021 04:53:52 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AC8424B0F4;
	Wed,  8 Sep 2021 04:53:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 0752F4B0EF
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Sep 2021 04:53:50 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ar9HIzgWnMgV for <kvmarm@lists.cs.columbia.edu>;
 Wed,  8 Sep 2021 04:53:49 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 18A164B08E
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Sep 2021 04:53:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631091228;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nc4j4dl7Mfy3UaeeqIQE2VyK+XGgfMm1ZSIO7tBQvPo=;
 b=AC9Xxfcn1IjltHqgPDwtMYgm1u74KfE77UZWRh4dCQppR7kWPW9saItnXCcrbD+2qXXwLE
 i48LysebnrOrXaX2HKS1PAnH+bUrNRLb0Yd5C+ttbXX75Eubc2xgVwKcMS5zya88K2PHAn
 ApfNzTzVZL8+zcEyAGnj+Ht4O60JXeg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-OXogNqJxN5uRkCGkqToC9Q-1; Wed, 08 Sep 2021 04:53:47 -0400
X-MC-Unique: OXogNqJxN5uRkCGkqToC9Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 r11-20020a5d4e4b000000b001575c5ed4b4so301715wrt.4
 for <kvmarm@lists.cs.columbia.edu>; Wed, 08 Sep 2021 01:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=Nc4j4dl7Mfy3UaeeqIQE2VyK+XGgfMm1ZSIO7tBQvPo=;
 b=j6OcShUmnjSFDy/VE2I/vhukFZ0kO7qo2ZMlNFXCH3U4dnXA3VjxAhh2pqtDR0Z1V9
 rMi57PHHgL8ZwgOyibbHSrtJFEoPdhlp7gC6X70BtcucrrGj3265otMRFCg6J8VqvRn2
 Wckh5btlN0t2bssu0sdm5mhANWrAxix+IXXjkdJ/SmobEWMne+G50NNVhToDM0pvEd4T
 ATSJout4wZEDkZz/+MkyKwup5cixIS6HTKvCGvrU2okN6vYbWq52j0mmLPdAKwhWcdLe
 WNehqzrzzX1hX/IS2LI2qa6Uw6DCVmOcztloOAqyMtd2GaaIQBe64sKKLLeyupQkPLsi
 S2bw==
X-Gm-Message-State: AOAM533ah5d+7jfohSz+I+mu8u+e+y6yZ7+WmO3ZAFB6MaC7wqo+AXT0
 KB7wKjquwfeQhv1IQEMqlLJMzkqliiy9JBi2KpVsAJtIGZXXeGGYRP2qKpt0GZyVxhkC4qedo6E
 vBH4iuqDYGXHGLVc/gKGWiTPi
X-Received: by 2002:a5d:4c4c:: with SMTP id n12mr2683930wrt.19.1631091226541; 
 Wed, 08 Sep 2021 01:53:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0OyQfyVtK5Exxd/DvtUJw960vgzgLYmRmmpe68nxixS4vZOHSGJ0zd5nIoDWIHANb9FHFng==
X-Received: by 2002:a5d:4c4c:: with SMTP id n12mr2683914wrt.19.1631091226349; 
 Wed, 08 Sep 2021 01:53:46 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id z6sm1426152wmp.1.2021.09.08.01.53.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Sep 2021 01:53:45 -0700 (PDT)
Subject: Re: [PATCH 3/3] docs/system/arm/virt: Fix documentation for the
 'highmem' option
To: Peter Maydell <peter.maydell@linaro.org>, Marc Zyngier <maz@kernel.org>
References: <20210822144441.1290891-1-maz@kernel.org>
 <20210822144441.1290891-4-maz@kernel.org>
 <CAFEAcA_J5W6kaaZ-oYtcRcQ5=z5nFv6bOVVu5n_ad0N8-NGzpg@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <fd41f05a-5ddb-6263-9efb-b130f7ac6817@redhat.com>
Date: Wed, 8 Sep 2021 10:53:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_J5W6kaaZ-oYtcRcQ5=z5nFv6bOVVu5n_ad0N8-NGzpg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Android Kernel Team <kernel-team@android.com>,
 QEMU Developers <qemu-devel@nongnu.org>, kvm-devel <kvm@vger.kernel.org>,
 kvmarm <kvmarm@lists.cs.columbia.edu>
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

Hi,

On 9/7/21 2:51 PM, Peter Maydell wrote:
> On Sun, 22 Aug 2021 at 15:45, Marc Zyngier <maz@kernel.org> wrote:
>> The documentation for the 'highmem' option indicates that it controls
>> the placement of both devices and RAM. The actual behaviour of QEMU
>> seems to be that RAM is allowed to go beyond the 4GiB limit, and
>> that only devices are constraint by this option.
>>
>> Align the documentation with the actual behaviour.
> I think it would be better to align the behaviour with the documentation.
>
> The intent of 'highmem' is to allow a configuration for use with guests
> that can't address more than 32 bits (originally, 32-bit guests without
> LPAE support compiled in). It seems like a bug that we allow the user
> to specify more RAM than will fit into that 32-bit range. We should
> instead make QEMU exit with an error if the user tries to specify
> both highmem=off and a memory size that's too big to fit.

That's my opinion too

Thanks

Eric
>
> thanks
> -- PMM
>

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
