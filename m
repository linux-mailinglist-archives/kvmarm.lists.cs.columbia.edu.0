Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id E149D3CF8AA
	for <lists+kvmarm@lfdr.de>; Tue, 20 Jul 2021 13:14:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7625E4B0C0;
	Tue, 20 Jul 2021 07:14:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Med-lDAAx8Mf; Tue, 20 Jul 2021 07:14:58 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7A7D34B0AD;
	Tue, 20 Jul 2021 07:14:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 00DEB4A193
 for <kvmarm@lists.cs.columbia.edu>; Tue, 20 Jul 2021 07:14:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ggq8Jd-ICW4f for <kvmarm@lists.cs.columbia.edu>;
 Tue, 20 Jul 2021 07:14:55 -0400 (EDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 02B7B40808
 for <kvmarm@lists.cs.columbia.edu>; Tue, 20 Jul 2021 07:14:54 -0400 (EDT)
Received: by mail-wm1-f49.google.com with SMTP id
 u5-20020a7bc0450000b02901480e40338bso1355366wmc.1
 for <kvmarm@lists.cs.columbia.edu>; Tue, 20 Jul 2021 04:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Scwye6C+1Um7vvUcoTZkRoyEhyT2SXL6uA5lCU/qAvo=;
 b=LMlxufPUPb2baVXBQ3VbdR5xUqZGe2i72q3p54Pd5N2AVVhCquwFd4vXoKMg94uLVz
 /DBufDYbJzPrm5yrCS7IHjx3emOa9cb1Q0XM2TNV21BgR6KoqX8NA7w21Ha2Cb8Bd+hV
 lYjoz7AFqJBKqgDZ1an+6fpOGpIp7utuszeDBxbe9tnYmbci25MtjjS1Z0BA9D7tUugc
 K+XnVi6J14aPrCi7ed8GeyQkKM6l5EkOw0hkLlsLXvhfBYVtPkFnZCVPZ08omY+DF4JU
 K5NO5ElFz242783F1DGmAGs4XfB2LfvVZcGvHX1zo46qXqGaitIlyqU1ZFEg27srQi13
 DbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Scwye6C+1Um7vvUcoTZkRoyEhyT2SXL6uA5lCU/qAvo=;
 b=Hn4+tdCcZNxcWRCzYOLBzggZE4bZ4vfXULy5wx2AL9IgX8TMvLSwswIVM1jO+mUMx8
 64eykzgoJhyIRB+xbXtboUplOJ2iHiQk7pAbggKPOI2sGyAt2O5PLXyTLq3k14SLo13J
 6d414IZEX9GKRQ6kSG7wN1u5F/SPKnzExmU9QJ4txiQUS0biRDGLg8a6Azg50DZJDMv/
 jQq+CeCEpzAAZRpYTivqpM8LaitjVyr3Lk0PjWbDeQH38qbQknxpYyTpYT6LbUxPVpZ8
 5cD/qZkKI5803VThI8GYI7zEzxXfP57pUDTu/Qnc4Bbm1o7iR2J//jxwbLc6GWbfsOG6
 llzg==
X-Gm-Message-State: AOAM532eKJB76rPxsXXyDDfE2uKZddPsNxngYzpxWYbYppWiw9mzaWeH
 BPxSZQrS4ug80O5hqkzvCtoofA==
X-Google-Smtp-Source: ABdhPJzLUrGFdy1juyhle9qtZp590ppxip5Hwthbwjk+yQgROG4vDqXreJVzBkI8J/0J3xXVMKtb6Q==
X-Received: by 2002:a1c:7314:: with SMTP id d20mr30516940wmb.167.1626779693865; 
 Tue, 20 Jul 2021 04:14:53 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:83e0:11ac:c870:2b97])
 by smtp.gmail.com with ESMTPSA id s13sm23219117wrm.13.2021.07.20.04.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jul 2021 04:14:53 -0700 (PDT)
Date: Tue, 20 Jul 2021 12:14:50 +0100
From: Quentin Perret <qperret@google.com>
To: Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH 06/14] KVM: arm64: Tolerate re-creating hyp mappings to
 set ignored bits
Message-ID: <YPawKkT2ZdVzQbM6@google.com>
References: <20210719104735.3681732-1-qperret@google.com>
 <20210719104735.3681732-7-qperret@google.com>
 <CA+EHjTzjT2iv=9jsTNquSAD-_AWqpyCKVPiuCBWGzpxcAkWf9w@mail.gmail.com>
 <YPalr09gA6tGYVtl@google.com>
 <CA+EHjTz__zjYY2D8+nEPq2F8__saxC0kApnn7_rs0r2VCR2Nzg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+EHjTz__zjYY2D8+nEPq2F8__saxC0kApnn7_rs0r2VCR2Nzg@mail.gmail.com>
Cc: kernel-team@android.com, qwandor@google.com, maz@kernel.org,
 linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On Tuesday 20 Jul 2021 at 11:59:27 (+0100), Fuad Tabba wrote:
> Thanks for the clarification. It makes sense to preserve the existing
> behavior, but I was wondering if a comment would be good, describing
> what merits a "needs update"?

Sure thing, I'll add something for v2.

Cheers,
Quentin
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
