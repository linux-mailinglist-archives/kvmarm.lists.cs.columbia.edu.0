Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2523825ED
	for <lists+kvmarm@lfdr.de>; Mon, 17 May 2021 09:56:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BD9924B1E9;
	Mon, 17 May 2021 03:56:00 -0400 (EDT)
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
	with ESMTP id Jheggna6MCBP; Mon, 17 May 2021 03:56:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9D0294B16D;
	Mon, 17 May 2021 03:55:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id ACB784B152
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 May 2021 03:55:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NtJuua194agR for <kvmarm@lists.cs.columbia.edu>;
 Mon, 17 May 2021 03:55:57 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 9E7BF4B14D
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 May 2021 03:55:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621238157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rT3LLQvP6Do94JcumEH0mRdHtxEizTm299DCgSoEINM=;
 b=cdtLDmmHFD0739eI7n+YXd5L7+jVWigrM4UWlHlOEn0wD7YTk8CQmM2dK8DcycUyhf37Uf
 OtsJCyXylOZhvZh/KoHP3vRutGd+ZcYDQ2o8UPpV6OY3aHiHLAJkrK7p76GmE2UsVryQZ1
 wQWRht1Xdm5q3GIYmDzBvN+NtP+p9Ls=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-N5kI8curMOKRXunsd5h1qw-1; Mon, 17 May 2021 03:55:55 -0400
X-MC-Unique: N5kI8curMOKRXunsd5h1qw-1
Received: by mail-ej1-f70.google.com with SMTP id
 m18-20020a1709062352b02903d2d831f9baso694399eja.20
 for <kvmarm@lists.cs.columbia.edu>; Mon, 17 May 2021 00:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rT3LLQvP6Do94JcumEH0mRdHtxEizTm299DCgSoEINM=;
 b=AjB9ITzKzzC6bO5XLtbGJL+aU94ZEQtvUW9OpYpiCP8cCcXeJygLiReScyZ4AF2Jty
 cqzhF1wnlKwW563yDyg5zgTST04AhAQeXknIztisd5imEnp2f5fTZ/aBaz9tl5FR3arU
 tb1F8dJ+FF/7i8aqSCFdnyeyCXP1Ql6quscou8We2xQoDtDuKY53U82knzw/fJP6yNtt
 GvhfuSGhP6BKerfsPDMZX34qr3A13+dCUUUIi7otB8ZK3MCvJfM4Eq46hpsp4qVvZIKL
 QnQU/Qd4Sev9fqpORh5AaICBz56xevJy7Mh2wRhxucToPnQzBQ5pKvaWKZ4PRSNauNqj
 y2pA==
X-Gm-Message-State: AOAM533B0CNnFa352Q27ndHWnhWFXxx182jNq3GH3AIz+H2V8zl2Hsne
 npISjlXsDCgHoPKL9fG9NNep/feg9ntbHXyYwI9rkZijcqijEqruckqx9k5uJBGj2ud+xYqWXny
 46amwuuysoVATrvloKWrQhIqK
X-Received: by 2002:a17:906:e096:: with SMTP id
 gh22mr61391558ejb.101.1621238154327; 
 Mon, 17 May 2021 00:55:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrz18w9HvZKC7KsjZznrJffVLg+kqHpMzA/+sGg41Ea6KJMAqBZQ42EgiiU411i9jT+XsoKQ==
X-Received: by 2002:a17:906:e096:: with SMTP id
 gh22mr61391531ejb.101.1621238154122; 
 Mon, 17 May 2021 00:55:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id i25sm8271504eje.6.2021.05.17.00.55.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 00:55:53 -0700 (PDT)
Subject: Re: [GIT PULL] KVM/arm64 fixes for 5.13, take #1
To: Marc Zyngier <maz@kernel.org>
References: <20210515095919.6711-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <84cda1d7-5467-f016-078d-0da0256b826b@redhat.com>
Date: Mon, 17 May 2021 09:55:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210515095919.6711-1-maz@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kernel-team@android.com, kvm@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Shaokun Zhang <zhangshaokun@hisilicon.com>,
 linux-arm-kernel@lists.infradead.org, Zhu Lingshan <lingshan.zhu@intel.com>,
 kvmarm@lists.cs.columbia.edu
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

On 15/05/21 11:59, Marc Zyngier wrote:
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvmarm-fixes-5.13-1

Pulled, thanks!

Paolo

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
